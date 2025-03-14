local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local leftSide = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"]
    }

    local rightSide =  Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Amber["300"]
    }

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,        
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.White
	}

    leftSide.Parent = parentFrame
    rightSide.Parent = parentFrame

	return parentFrame
end