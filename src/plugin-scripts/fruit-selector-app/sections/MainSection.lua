local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)



return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    

    local frameUp = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .5, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Yellow["100"]
	}
    
    local frameDown =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .5, 0),
        Position = UDim2.new(0, 0, .5, 0),
        BackgroundColor3 = Util.Colors.Emerald["300"]
	}

    local frameLeft = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Indigo["100"]
	}
    
    local frameRight =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Amber["300"]
	}

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    if Props.Show then
        frameLeft.Parent = frameUp
        frameRight.Parent = frameUp

        Props.LeftComponent.Parent = frameLeft
        Props.RightComponent.Parent = frameRight
        Props.BottomComponent.Parent = frameDown

        frameUp.Parent = parentFrame
        frameDown.Parent = parentFrame
    end

	return parentFrame
end
