local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local titleSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        [Fusion.Children] = {
            Props.Title
        }
    }

    local buttonsSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            Props.ReplacerButtons
        }
    }

    local optionsTitleSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 80),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            Props.OptionsTitle
        }
    }

    local optionsSlot = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 80),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            Props.Options
        }
    }


    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            titleSlot,
            buttonsSlot,
            optionsTitleSlot,
            optionsSlot
        }
    }

	return parentFrame
end
