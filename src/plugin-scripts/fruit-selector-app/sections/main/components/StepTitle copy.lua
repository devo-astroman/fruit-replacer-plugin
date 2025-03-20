local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)
local PluginTheme = require(script.Parent.Parent.Parent.Parent.PluginTheme)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local myTheme = Themer.NewTheme(Scope,PluginTheme)
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	--[[ local Themer = OnyxUI.Themer ]]
	
	print("created theme ", myTheme)
	print("BEFORE THEME ", Themer.Theme:now())
	print("Flag ", Themer.Theme:is(myTheme))
	return Themer.Theme:is(myTheme):during(function()
		print("during ", Themer.Theme:now()) --> bar

		local nStep = Props.NStep
		local NowTheme = Themer.Theme:now()

		return Scope:Text {
			Text = Props.Instruction,
			TextColor3 = Scope:Computed(function(use)
				return use(NowTheme.Colors.Primary.Main)
			end),
			--[[ TextColor3 = Util.Colors.Green["700"], ]]
			Position = Props.Position,
			Size = Props.Size,
			TextSize = 10,
			PaddingLeft = UDim.new(0,0),
			TextXAlignment = Props.TextXAlignment
		}

		
	end)
end
--[[ 	print("AFTER THEME ", Themer.Theme:now())


		Padding = Scope:Computed(function(Use)
			return UDim.new(0, Use(Theme.Spacing["2"]))
		end),

	
	local nStep = Props.NStep

	return Scope:Text {
		Text = Props.Instruction,
		TextColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Primary)
		end),
		 TextColor3 = Util.Colors.Green["700"], 
		Position = Props.Position,
		Size = Props.Size,
		TextSize = 10,
		PaddingLeft = UDim.new(0,0),
		TextXAlignment = Props.TextXAlignment
	}
end
]]