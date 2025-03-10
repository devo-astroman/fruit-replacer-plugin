local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    --[[ 
    header: 10%
    body: 80%
    footer: 10%
     ]]

    local header = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Yellow["100"]
	}

    local body = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .8, 0),
        Position = UDim2.new(0, 0, .1, 0),
        BackgroundColor3 = Util.Colors.Indigo["100"],
	}
    
    local footer =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .1, 0),
        Position = UDim2.new(0, 0, .9, 0),
        BackgroundColor3 = Util.Colors.Emerald["300"]
	}

    local leftSide = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Indigo["100"]
    }

    local rightSide =  Scope:Frame {
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

    leftSide.Parent = body
    rightSide.Parent = body

    header.Parent = parentFrame
    body.Parent = parentFrame
    footer.Parent = parentFrame


    Props.Title.Parent = header
    Props.Left.Parent = leftSide
    Props.Right.Parent = rightSide
    Props.Footer.Parent = footer

	return parentFrame
end