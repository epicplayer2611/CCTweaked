local ButtonAPI = require("ButtonAPI")
local monitor = peripheral.find("monitor")

autoMonitor = false
monitorMode = false

if AutoMonitor == true then
    if monitor then
        ButtonAPI.setOutput(monitor) -- Render buttons on the monitor
    else
        ButtonAPI.setOutput(term) -- Fall back to the terminal
    end
elseif AutoMonitor == false then
    if monitorMode == true then
        ButtonAPI.setOutput(monitor) -- Render buttons on the monitor
    else
        ButtonAPI.setOutput(term) -- Fall back to the terminal
    end
end


-- Button actions
local function onButtonA()
    print("Button A clicked!")
end

local function onButtonB()
    print("Button B clicked!")
end

local function onToggle()
    print("Toggle button state changed!")
end

-- Create buttons
--ButtonAPI.createButton(x, y, width, height, label, onClick, offColor, onColor, toggleable)
ButtonAPI.createButton(2, 2, 5, 3, "Push A", onButtonA, colors.red, colors.orange, false) -- Pushable button
ButtonAPI.createButton(2, 6, 5, 3, "Push B", onButtonB, colors.blue, colors.cyan, false) -- Pushable button
ButtonAPI.createButton(2, 10, 5, 3, "Toggle", onToggle, colors.gray, colors.lime, true) -- Toggleable button


--Run ButtonAPI parallel
parallel.waitForAny(ButtonAPI.run)