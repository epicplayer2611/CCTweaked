-- init.lua
local services = {}
local running  = {}

-- Load a service definition from a file
local function loadService(path)
    local fn, err = loadfile(path)
    if not fn then error("Failed to load service: " .. err) end
    local svc = fn()
    services[svc.name] = svc
    return svc
end

-- Build a wrapped coroutine for a service so the supervisor can restart it
local function makeRunner(svc)
    return function()
        while true do
            local ok, err = pcall(function() svc:start() end)
            if not ok then
                print("[init] Service '" .. svc.name .. "' crashed: " .. tostring(err))
                print("[init] Restarting in 3s...")
                sleep(3)
            else
                -- start() returned cleanly — service was stopped intentionally
                break
            end
        end
    end
end

-- Supervisor loop: rebuild the parallel task list dynamically isn't possible
-- mid-run, so we use a restart flag and re-launch the whole parallel call.
local function supervisor()
    while true do
        local tasks = {}
        for name, svc in pairs(running) do
            tasks[#tasks + 1] = makeRunner(svc)
        end

        if #tasks == 0 then
            sleep(1) -- idle if no services
        else
            parallel.waitForAll(table.unpack(tasks))
        end
    end
end

-- Public API
local init = {}

function init.start(name)
    if not services[name] then error("Unknown service: " .. name) end
    running[name] = services[name]
    print("[init] Started: " .. name)
end

function init.stop(name)
    running[name] = nil
    print("[init] Stopped: " .. name)
end

function init.status()
    print("=== Service Status ===")
    for name in pairs(services) do
        local state = running[name] and "RUNNING" or "STOPPED"
        print(string.format("  %-20s %s", name, state))
    end
end

return init, supervisor
