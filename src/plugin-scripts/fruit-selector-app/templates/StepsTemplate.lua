local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local leftComponent = Props.LeftComponent
    local middleComponent = Props.MiddleComponent
    local rightComponent = Props.RightComponent

    local left = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["700"],
        [Fusion.Children] = {leftComponent}
	}

    local middle = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(.333, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["100"],
        --[[ [Fusion.Children] = {middleComponent} ]]
	}

    local right = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.333, 0, 1, 0),
        Position = UDim2.new(.666, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["100"],
        --[[ [Fusion.Children] = {rightComponent} ]]
	}

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,        
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.White,
        [Fusion.Children] = {
            left,
            middle,
            right
        }
	}

	return parentFrame
end