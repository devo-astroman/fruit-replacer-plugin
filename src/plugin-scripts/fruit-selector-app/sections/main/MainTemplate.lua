local Fusion = require(script.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
    local Themer = OnyxUI.Themer
    local Theme = Themer.Theme:now()
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local leftComponent = Props.LeftComponent
    local middleComponent = Props.MiddleComponent
    local rightComponent = Props.RightComponent

    local leftSlot = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["700"],
        [Fusion.Children] = {leftComponent}
	}

    local middleSlot = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(.333, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["100"],
        [Fusion.Children] = {middleComponent}
	}

    local rightSlot = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(.666, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Red["700"],
        [Fusion.Children] = {rightComponent}
	}

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(0, 600, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Primary.Contrast)
		end),
        [Fusion.Children] = {
            leftSlot,
            middleSlot,
            rightSlot
        }
	}

	return parentFrame
end