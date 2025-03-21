local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()

	local question = Props.Message
	local onAnswer = Props.OnAnswer
	
	local questionText = Scope:Text {
		Text = question,
		TextColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Secondary.Main)
		end),
		Size = UDim2.new(0, 300, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
		TextSize = Scope:Computed(function(use)
			return use(Theme.TextSize["0.875"])
		end),
		PaddingLeft = UDim.new(0,0),
		TextXAlignment = Enum.TextXAlignment.Left
	}

	local cancelButton = Scope:Button {
        StrokeEnabled = false,
        CornerRadius = UDim.new(0,0),
        Padding = 0,
		Content = {"Cancel"},
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(0, 10, 0, 35),
        OnActivated = function()
			onAnswer(false)
		end 
    }

	local confirmButton = Scope:Button {
        StrokeEnabled = false,
        CornerRadius = UDim.new(0,0),
        Padding = 0,
		Content = {"Confirm"},
        Size = UDim2.new(0, 50, 0, 20),
        Position = UDim2.new(0, 80, 0, 35),
        OnActivated = function()
			onAnswer(true)
		end 
    }


	local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["500"],
        PaddingLeft = UDim.new(0, 20),
        [Fusion.Children] = {
            questionText,
            cancelButton,
			confirmButton
        }
    }

	return parentFrame
end