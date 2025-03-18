local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local SwitchValue = require(script.Parent.SwitchValue)

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

    print("SwitchValue ", SwitchValue)
    local value1 = Fusion.Value(Scope, true)
    local switchValue1 = SwitchValue(Scope,{
        Index = 1,
        Text = "Delete items to be replaced",
        Value = value1,
        OnOptionChange = function()
            print("should change 1")
            --[[ local switchChanged = optionValues[index] ]]
            value1:set(not(peek(value1)))
        end
    })

    --[[ local switchValue2 = SwitchValue(Scope,{
        Index = 2,
        Text = "Copy Orientation",
        OnOptionChange = function()
            print("should change 2")
        end        
    })

    local switchValue3 = SwitchValue(Scope,{
        Index = 3,
        Text = "Copy Scale",
        OnOptionChange = function()
            print("should change 3")
        end        
    })

    local switchValue4 = SwitchValue(Scope,{
        Index = 4,
        Text = "Confirm action",
        OnOptionChange = function()
            print("should change 4")
        end        
    }) ]]

    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 0, 0), 
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.Y,
        [Fusion.Children] = {
            switchValue1,
            --[[ switchValue2,
            switchValue3,
            switchValue4 ]]
        }
    }

    return parentFrame
end
