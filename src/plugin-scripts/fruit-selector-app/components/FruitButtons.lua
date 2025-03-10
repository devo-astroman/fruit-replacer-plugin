local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local ButtonGo = require(script.Parent.ButtonGo)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	local button1 = ButtonGo(Scope, { Text="Apple" ,
     Size = UDim2.new(.5, 0, .33, 0),
     Position = UDim2.new(.25, 0, 0, 0),
     OnActivated = Props.OnActivatedApple
    })

	local button2 = ButtonGo(Scope, { Text="Pear" ,
     Size = UDim2.new(.5, 0, .33, 0),
     Position = UDim2.new(.25, 0, .33, 0),
     OnActivated = Props.OnActivatedPear
    })

	local button3 = ButtonGo(Scope, { Text="Banana" ,
     Size = UDim2.new(.5, 0, .33, 0),
     Position = UDim2.new(.25, 0, .66, 0),
     OnActivated = Props.OnActivatedBanana
    })

    local frameParent = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .3, 0),
        Position = UDim2.new(0, 0, .2, 0),
        BackgroundColor3 = Util.Colors.Yellow["100"]
	}

    button1.Parent = frameParent
    button2.Parent = frameParent
    button3.Parent = frameParent


	return frameParent
end