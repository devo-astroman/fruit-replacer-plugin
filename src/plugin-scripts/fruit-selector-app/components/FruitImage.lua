local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()


    local titleText = Scope:Text {		
		Text = Props.fruitTitle,
		TextColor3 = Util.Colors.Green["700"],
        Size = UDim2.new(1, 0, .3, 0),
        Position = UDim2.new(0, 0, 0, 0),
	}

    local fruitImage = Scope:Image{
        Image = Props.fruitImage,
        Size = UDim2.new(.6, 0, .5, 0),
        Position = UDim2.new(.2, 0, .3, 0),
    }

    local frameParent = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, .8, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["100"]
	}

    titleText.Parent = frameParent
    fruitImage.Parent = frameParent

	return frameParent
end