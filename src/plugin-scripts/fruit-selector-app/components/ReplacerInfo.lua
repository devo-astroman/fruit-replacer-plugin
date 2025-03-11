local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

    local fruitSelected = Props.fruitTitle
    local elemsSelected = Props.elementsSelected


    local fruit = Scope:Text {		
		Text = fruitSelected,
		TextColor3 = Util.Colors.Green["700"],
        Size = UDim2.new(1, 0, .3, 0),
        Position = UDim2.new(0, 0, 0, 0),
	}

    local selectedElements = Scope:Text {		
		Text = elemsSelected,
		TextColor3 = Util.Colors.Green["700"],
        Size = UDim2.new(1, 0, .1, 0),
        Position = UDim2.new(0, 0, .3, 0),
	}

    local frameParent = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, .8, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Green["100"]
	}

    fruit.Parent = frameParent
    selectedElements.Parent = frameParent

	return frameParent
end