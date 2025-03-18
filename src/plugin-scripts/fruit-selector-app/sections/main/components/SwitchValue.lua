local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local peek = Fusion.peek

    -- Callback function from props
    local onOptionChange = Props.OnOptionChange or function() end

    -- ✅ List of option labels
   --[[  local optionLabels = {
        "Delete items to be replaced",
        "Copy orientation",
        "Copy scale",
        "Confirm action"
    } ]]

    -- ✅ Store boolean states for each option
    local optionValues = {} -- Table to track switch states
    local index = Props.Index
    local text = Props.Text
    -- ✅ Function to create each option
    
    local switchValue = Props.Value
    --[[ local switchValue = Fusion.Value(Scope, false) -- Default false ]]
    optionValues[index] = switchValue -- Store reference to this value

    -- Function to call when the switch is toggled
    local function onSwitchChanged(index)
        --[[ local switchChanged = optionValues[index]
        switchChanged:set(not(peek(switchChanged))) ]]
        onOptionChange(index) -- Call the callback with updated values
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
    --[[ end ]]

end
