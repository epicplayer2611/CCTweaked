
local ButtonAPI = {}

-- Store buttons with positions, colors, actions, and toggleable states
ButtonAPI.buttons = {}
ButtonAPI.output = term -- Default to the terminal

-- Function to set the output target (terminal or monitor)
function ButtonAPI.setOutput(target)
    ButtonAPI.output = target or term
    ButtonAPI.output.setBackgroundColor(colors.black)
    ButtonAPI.output.clear()
end

-- Function to create a button
function ButtonAPI.createButton(x, y, width, height, label, onClick, offColor, onColor, toggleable)
    toggleable = toggleable or false

    -- Add button to the list
    table.insert(ButtonAPI.buttons, {
        x = x,
        y = y,
        width = width,
        height = height,
        label = label,
        onClick = onClick,
        offColor = offColor or colors.gray, -- Default off state color
        onColor = onColor or colors.green, -- Default on state color
        toggleable = toggleable,           -- Is the button toggleable
        isPressed = false                  -- Button state (only for toggleable buttons)
    })
end

-- Function to render all buttons
function ButtonAPI.renderButtons()
    ButtonAPI.output.setBackgroundColor(colors.black)
    ButtonAPI.output.clear()
    for _, button in ipairs(ButtonAPI.buttons) do
        local bgColor
        if button.toggleable then
            bgColor = button.isPressed and button.onColor or button.offColor -- Toggleable button color
        else
            bgColor = button.offColor -- Default color for pushable buttons
        end

        -- Set the button background color
        ButtonAPI.output.setBackgroundColor(bgColor)

        -- Draw button area
        for i = 1, button.height do
            ButtonAPI.output.setCursorPos(button.x, button.y + i - 1)
            ButtonAPI.output.write(string.rep(" ", button.width))
        end

        -- Draw label
        ButtonAPI.output.setTextColor(colors.white)
        ButtonAPI.output.setCursorPos(button.x + math.floor((button.width - #button.label) / 2),
            button.y + math.floor(button.height / 2))
        ButtonAPI.output.write(button.label)
    end
end

-- Function to handle input (supports both terminal and monitor clicks)
function ButtonAPI.handleInput()
    while true do
        local event, side, x, y
        if ButtonAPI.output == term then
            -- Handle terminal input
            event, side, x, y = os.pullEvent("mouse_click")
        else
            -- Handle monitor touch input
            event, side, x, y = os.pullEvent("monitor_touch")
        end

        -- Check if the click is within a button
        for _, button in ipairs(ButtonAPI.buttons) do
            if x >= button.x and x <= button.x + button.width - 1 and
               y >= button.y and y <= button.y + button.height - 1 then
                -- If toggleable, toggle state
                if button.toggleable then
                    button.isPressed = not button.isPressed
                else
                    -- Pushable: Temporarily set to "pressed" color
                    ButtonAPI.output.setBackgroundColor(button.onColor)
                    for i = 1, button.height do
                        ButtonAPI.output.setCursorPos(button.x, button.y + i - 1)
                        ButtonAPI.output.write(string.rep(" ", button.width))
                    end
                    sleep(0.1) -- Simulate the button press visually
                end

                -- Trigger button action
                button.onClick()
            end
        end

        -- Redraw buttons after input
        ButtonAPI.renderButtons()
    end
end

function ButtonAPI.run()
    ButtonAPI.renderButtons()
    ButtonAPI.handleInput()
end

return ButtonAPI
