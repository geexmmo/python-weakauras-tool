function (input_string, path)
    -- libs
    dofile(path .. "/lua/libs/wowhelpers.lua")
    dofile(path .. "/lua/libs/base64.lua")
    pcall(function() dofile(path .. "/lua/libs/LibStub/LibStub.lua") end)
    dofile(path .. "/lua/libs/LibCompress/LibCompress.lua")
    local Compresser = LibStub:GetLibrary("LibCompress")
    dofile(path .. "/lua/libs/AceSerializer-3.0/AceSerializer-3.0.lua")
    local Serializer = LibStub:GetLibrary("AceSerializer-3.0")
    local LibSerialize = LibStub("LibSerialize")
    local JSON = dofile(path .. "/lua/libs/json.lua")

    -- execution
    local luatable = JSON:decode(input_string)
    -- local t = luatable
    if not luatable or not luatable.d then
        return ('failed to decode JSON to lua table')
    end

    function fixNumericIndexes(tbl)
        local fixed = {}
        for k, v in pairs(tbl) do
            if tonumber(k) and tonumber(k) > 0 then
                fixed[tonumber(k)] = v
            else
                fixed[k] = v
            end
        end
        return fixed
    end

    -- fixes tables; the lua-json process can break these
    function fixWATables(t)
        if t.triggers then
            t.triggers = fixNumericIndexes(t.triggers)
            for n in ipairs(t.triggers) do
                if t.triggers[n].trigger and type(t.triggers[n].trigger.form) ==
                    "table" and t.triggers[n].trigger.form.multi then
                    t.triggers[n].trigger.form.multi = fixNumericIndexes(
                                                           t.triggers[n].trigger
                                                               .form.multi)
                end

                if t.triggers[n].trigger and t.triggers[n].trigger.talent and
                    t.triggers[n].trigger.talent.multi then
                    t.triggers[n].trigger.talent.multi = fixNumericIndexes(
                                                             t.triggers[n]
                                                                 .trigger.talent
                                                                 .multi)
                end

                if t.triggers[n].trigger and t.triggers[n].trigger.specId and
                    t.triggers[n].trigger.specId.multi then
                    t.triggers[n].trigger.specId.multi = fixNumericIndexes(
                                                             t.triggers[n]
                                                                 .trigger.specId
                                                                 .multi)
                end

                if t.triggers[n].trigger and t.triggers[n].trigger.herotalent and
                    t.triggers[n].trigger.herotalent.multi then
                    t.triggers[n].trigger.herotalent.multi = fixNumericIndexes(
                                                                 t.triggers[n]
                                                                     .trigger
                                                                     .herotalent
                                                                     .multi)
                end

                if t.triggers[n].trigger and t.triggers[n].trigger.actualSpec then
                    t.triggers[n].trigger.actualSpec = fixNumericIndexes(
                                                           t.triggers[n].trigger
                                                               .actualSpec)
                end

                if t.triggers[n].trigger and t.triggers[n].trigger.arena_spec then
                    t.triggers[n].trigger.arena_spec = fixNumericIndexes(
                                                           t.triggers[n].trigger
                                                               .arena_spec)
                end
            end
        end

        if t.load and t.load.talent and t.load.talent.multi then
            t.load.talent.multi = fixNumericIndexes(t.load.talent.multi)
        end
        if t.load and t.load.talent2 and t.load.talent2.multi then
            t.load.talent2.multi = fixNumericIndexes(t.load.talent2.multi)
        end
        if t.load and t.load.talent3 and t.load.talent3.multi then
            t.load.talent3.multi = fixNumericIndexes(t.load.talent3.multi)
        end
        if t.load and t.load.herotalent and t.load.herotalent.multi then
            t.load.herotalent.multi = fixNumericIndexes(t.load.herotalent.multi)
        end

        if t.load and t.load.class_and_spec and t.load.class_and_spec.multi then
            t.load.class_and_spec.multi =
                fixNumericIndexes(t.load.class_and_spec.multi)
        end

        return t
    end

    luatable.d = fixWATables(luatable.d)
    if luatable.c then
        for i = 1, #luatable.c do
            if luatable.c[i] then luatable.c[i] = fixWATables(luatable.c[i]) end
        end
    end

    local serialized = Serializer:Serialize(luatable)
    if not (serialized) then return ('failed to serialize lua table') end
    local compressed = Compresser:CompressHuffman(serialized)
    if not (compressed) then
        return ('failed to compress serialized lua table')
    end
    local encoded = encodeB64(compressed)
    if not (encoded) then
        return ('failed to encode compressed serialized lua table')
    end

    return encoded
end