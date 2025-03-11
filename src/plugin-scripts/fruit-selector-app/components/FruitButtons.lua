local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local ButtonApp = require(script.Parent.ButtonApp)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	local button1 = ButtonApp(Scope, { Text="Apple" ,
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = Props.OnActivatedApple
    })

	local button2 = ButtonApp(Scope, { Text="Pear" ,
     Position = UDim2.new(0, 0, .33, 0),
     OnActivated = Props.OnActivatedPear
    })

	local button3 = ButtonApp(Scope, { Text="Banana" ,
     Position = UDim2.new(0, 0, .66, 0),
     OnActivated = Props.OnActivatedBanana
    })

    local frameParent = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(.5, 0, .5, 0),
        Position = UDim2.new(.125, 0, .125, 0),
        BackgroundColor3 = Util.Colors.Red["100"]
	}

    button1.Parent = frameParent
    button2.Parent = frameParent
    button3.Parent = frameParent


	return frameParent
end