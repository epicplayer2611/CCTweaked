-- startup.lua  (placed in / so CC runs it on boot)
local init, supervisor = require("init")

-- Load service definitions
init.loadService("services/logger.lua")
init.loadService("services/network.lua")
init.loadService("services/myservice.lua")

-- Autostart services
for name, svc in pairs(services) do
    if svc.autostart then init.start(name) end
end

-- Run the supervisor alongside a simple shell
parallel.waitForAny(
    supervisor,         -- manages all background services
    function()          -- foreground shell for service control
        while true do
            io.write("> ")
            local cmd, arg = read():match("(%S+)%s*(%S*)")
            if cmd == "start"  then init.start(arg)
            elseif cmd == "stop"   then init.stop(arg)
            elseif cmd == "status" then init.status()
            elseif cmd == "exit"   then break
            end
        end
    end
)
