local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	return Scope:Text {		
		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["2"]))
		end),
		Text = Props.greetMsg,
		TextColor3 = Util.Colors.Green["700"],
	}
end