
local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)

local GreetText = {}
function GreetText.builder(plugin)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope


	local Themer = OnyxUI.Themer

	
	return function(Scope: Fusion.Scope<any>, Props)
		local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
		local Theme = Themer.Theme:now()
	
		return Scope:Text {
			BackgroundColor3 = Util.Colors.Green["700"],
			Padding = Scope:Computed(function(Use)
				return UDim.new(0, Use(Theme.Spacing["2"]))
			end),
			Text = "Hello from Onyx Component!",
		}
	end
end

return GreetText