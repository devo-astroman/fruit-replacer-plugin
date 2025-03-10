local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local ButtonGo = require(script.Parent.ButtonGo)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	local button1 = ButtonGo(Scope, { Text="Home" ,
     Size = UDim2.new(1, 0, .33, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        print("Clicked Home")
    end})
	local button2 = ButtonGo(Scope, { Text="Profile" ,
     Size = UDim2.new(1, 0, .33, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        print("Clicked Home")
    end})
	local button3 = ButtonGo(Scope, { Text="Settings" ,
     Size = UDim2.new(1, 0, .33, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        print("Clicked Home")
    end})

	local menuItems = {
		button1
	}


	return Scope:MenuFrame {		
		Items = menuItems,
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.new(.5, 0, .5, 0),
	}
end