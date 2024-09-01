function(input_string, path)
    -- libs
    dofile(path .. "/lua/libs/wowhelpers.lua" )
    dofile(path .. "/lua/libs/base64.lua" )
    pcall(function() dofile(path .. "/lua/libs/LibStub/LibStub.lua" ) end)
    dofile(path .. "/lua/libs/LibCompress/LibCompress.lua" )
    local Compresser = LibStub:GetLibrary("LibCompress")
    dofile(path .. "/lua/libs/AceSerializer-3.0/AceSerializer-3.0.lua" )
    local Serializer = LibStub:GetLibrary("AceSerializer-3.0")
    local LibSerialize = LibStub("LibSerialize")
    local JSON = dofile(path .. "/lua/libs/json.lua")

    -- execution
    local luatable = JSON:decode(input_string)
    if not (luatable) then
        return('failed to convert JSON to lua table')
    end
    local serialized = Serializer:Serialize(luatable)
    if not (serialized) then
        return('failed to serialize lua table')
    end
    local compressed = Compresser:CompressHuffman(serialized)
    if not (compressed) then
        return('failed to compress serialized lua table')
    end
    local encoded = encodeB64(compressed)
    if not (encoded) then
        return('failed to encode compressed serialized lua table')
    end

    return encoded
end