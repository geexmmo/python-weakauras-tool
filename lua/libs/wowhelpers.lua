local bit = require("bit")

function strmatch(a,b)
	return string.match(a,b)
end

function sort(a, b)
    return table.sort(a, b)
end

function CreateFrame()
    frame = {}
    frame.SetScript = function() end
    frame.Hide = function() end
    frame.Show = function() end
    frame.IsShown = function() end
    frame.RegisterEvent = function() end
    return frame
end