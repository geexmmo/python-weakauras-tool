function(input_string, path)
    -- libs
    dofile(path .. "/lua/libs/wowhelpers.lua" )
    dofile(path .. "/lua/libs/LibStub/LibStub.lua")
    dofile(path .. "/lua/libs/LibDeflate/LibDeflate.lua")
    dofile(path .. "/lua/libs/LibSerialize/LibSerialize.lua")
    local LibDeflate = LibStub:GetLibrary("LibDeflate")
    local LibSerialize = LibStub("LibSerialize")
    local JSON = dofile(path .. "/lua/libs/json.lua")

    -- execution
    if type(input_string) ~= "string" then
      return('invalid string type')
    end
    local strlen = #input_string
    if strlen == 1 then
      return('invalid string len')
    end
    local _, _, encodeVersion, encoded = input_string:find("^(!WA:%d+!)(.+)$")

    if encodeVersion then
        encodeVersion = tonumber(encodeVersion:match("%d+"))
    else
        encoded, encodeVersion = input_string:gsub("^%!", "")
    end
        
    if encodeVersion < 2 then
      return('unsupported wa version')
    end
    
    local decoded = LibDeflate:DecodeForPrint(encoded)

    local decompressed, errorMsg
    if decoded then
      decompressed = LibDeflate:DecompressDeflate(decoded)
    else
      return('failed to decode')
    end

    if not (decompressed) then
      return('failed to decompress')
    end

    local success, deserialized = LibSerialize:Deserialize(decompressed)

    if not (success) then
      return('deserialization failed')
    end
    return JSON:encode(deserialized)
end