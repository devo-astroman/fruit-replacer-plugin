local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local SwitchValue = require(script.Parent.SwitchValue)

return function(Scope: Fusion.Scope<any>, Props)
    local Themer = OnyxUI.Themer
	local Theme = Themer.Theme:now()
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local peek = Fusion.peek

    -- Callback function from props
    local onOptionChange = Props.onOptionChange or function() end
    
    local switchValue1 = SwitchValue(Scope,{
        Key = 1,
        Text = "Delete items to be replaced",
        Value = Props.Value1.value,
        OnOptionChange = function( )
            print("should change 1")
            Props.OnOptionChange(Props.Value1.key)
        end
    })

    local switchValue2 = SwitchValue(Scope,{
        Key = 2,
        Text = "Copy Orientation",
        Value = Props.Value2.value,
        OnOptionChange = function( )
            print("should change 2")
            Props.OnOptionChange(Props.Value2.key)
        end
    })

    local switchValue3 = SwitchValue(Scope,{
        Key = 3,
        Text = "Copy Scale",
        Value = Props.Value3.value,
        OnOptionChange = function( )
            print("should change 3")
            Props.OnOptionChange(Props.Value3.key)
        end
    })

    local switchValue4 = SwitchValue(Scope,{
        Key = 4,
        Text = "Need Confirm",
        Value = Props.Value4.value,
        OnOptionChange = function( )
            print("should change 4")
            Props.OnOptionChange(Props.Value4.key)
        end
    })

    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 150, 0, 200), 
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Gray["700"],
        AutomaticSize = Enum.AutomaticSize.Y,
        [Fusion.Children] = {
            switchValue1,
            switchValue2,
            switchValue3,
            switchValue4
        }
    }
    
    return parentFrame

end