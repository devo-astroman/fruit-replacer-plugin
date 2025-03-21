local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
    local Themer = OnyxUI.Themer
	local Theme = Themer.Theme:now()
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local key = Props.Key
    local text = Props.Text
    local switchValue = Props.Value
    local onOptionChange = Props.OnOptionChange or function() end

    return Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30), -- Each item height
        Position = UDim2.new(0, 0, 0, 20), 
        [Fusion.Children] = {
            Scope:SwitchInput {
                Size = UDim2.new(0, 30, 0, 15), -- Checkbox size
                CornerRadius = UDim.new(0,0),
                StrokeThickness = .5,
                Position = UDim2.new(0, 0, 0, key * 25),
                Switched = switchValue,
                OnActivated = function()
                    onOptionChange(key)
                end
            },
            Scope:Text {
                Text = text,
                Size = UDim2.new(1, 0, 1, 0), -- Adjust width for text
                Position = UDim2.new(0, 50, 0, key * 25),
                TextSize = Scope:Computed(function(use)
                    return use(Theme.TextSize["0.875"])
                end),
                BackgroundTransparency = 1,
                TextColor3 = Scope:Computed(function(use)
                    return use(Theme.Colors.Secondary.Main)
                end),
                
            }
        }
    }

end
