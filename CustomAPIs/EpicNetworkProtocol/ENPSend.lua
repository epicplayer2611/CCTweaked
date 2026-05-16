--EpicNetworkProtocol Sender
local function loadData(path)
    if not fs.exists(path) then
        return {}   -- safe default
    end
    local f = fs.open(path, "r")
    local raw = f.readAll()
    f.close()
    return textutils.unserialise(raw) or {}
end

local protocolData = loadData("ENPData.dat")

