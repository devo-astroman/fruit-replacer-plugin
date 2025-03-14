local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local titleSlot = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        [Fusion.Children] = {
            Props.Title
        }
    }

    local listTextBoxSlot = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        [Fusion.Children] = {
            Props.ListTextBox
        }
    }


    local parentFrame = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        [Fusion.Children] = {
            titleSlot,
            listTextBoxSlot
        }
    }

	return parentFrame
    --[[ return selectTextBox ]]
end
