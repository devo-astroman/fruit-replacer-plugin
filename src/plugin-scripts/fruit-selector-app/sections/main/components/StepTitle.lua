local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer	
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()
	local nStep = Props.NStep	

	return Scope:Text {
		Text = Props.Instruction,
		TextColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Primary.Main)
		end),
		--[[ TextColor3 = Util.Colors.Green["700"], ]]
		Position = Props.Position,
		Size = Props.Size,
		TextSize = 10,
		PaddingLeft = UDim.new(0,0),
		TextXAlignment = Props.TextXAlignment
	}
end