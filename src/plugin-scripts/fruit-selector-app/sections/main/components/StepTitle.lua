local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Themer = OnyxUI.Themer
	local Theme = Themer.Theme:now()
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local nStep = Props.NStep

	return Scope:Text {
		Text = Props.Instruction,
		TextColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Primary.Main)
		end),
		Position = Props.Position,
		Size = Props.Size,
		TextSize = Scope:Computed(function(use)
			return use(Theme.TextSize["1"])
		end),
		PaddingLeft = UDim.new(0,0),
		TextXAlignment = Props.TextXAlignment
	}
end