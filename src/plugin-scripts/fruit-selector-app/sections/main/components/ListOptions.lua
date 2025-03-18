local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local peek = Fusion.peek

    -- Callback function from props
    local onOptionChange = Props.onOptionChange or function() end

    -- ✅ List of option labels
    local optionLabels = {
        "Delete items to be replaced",
        "Copy orientation",
        "Copy scale",
        "Confirm action"
    }

    -- ✅ Store boolean states for each option
    local optionValues = {} -- Table to track switch states

    -- ✅ Function to create each option
    local function createOption(index, text)
        local switchValue = Fusion.Value(Scope, false) -- Default false
        optionValues[index] = switchValue -- Store reference to this value

        -- Function to call when the switch is toggled
        local function onSwitchChanged(index)
            local switchChanged = optionValues[index]
            switchChanged:set(not(peek(switchChanged)))
            onOptionChange(optionValues) -- Call the callback with updated values
        end
        return Scope:Frame {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 30), -- Each item height
            [Fusion.Children] = {
                Scope:SwitchInput {
                    Size = UDim2.new(0, 40, 0, 30), -- Checkbox size
                    Position = UDim2.new(0, 0, 0, index * 40),
                    Switched = switchValue,
                    OnActivated = function()
                        onSwitchChanged(index)
                    end 
                },
                Scope:Text {
                    Text = text,
                    Size = UDim2.new(1, 0, 1, 0), -- Adjust width for text
                    Position = UDim2.new(0, 50, 0, index * 40),
                    TextSize = 12,
                    BackgroundTransparency = 1,
                    TextColor3 = Util.Colors.Green["950"]
                }
            }
        }
    end

    -- ✅ Parent frame containing the options
    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 0, 0), -- Width fixed, height dynamic
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.Y, -- ✅ Adjust height dynamically
        [Fusion.Children] = {
            createOption(1, optionLabels[1]),
            createOption(2, optionLabels[2]),
            createOption(3, optionLabels[3]),
            createOption(4, optionLabels[4])
        }
    }

    return parentFrame
end
