local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local peek = Fusion.peek

    local key = Props.Key
    local text = Props.Text
    local switchValue = Props.Value
    local onOptionChange = Props.OnOptionChange or function() end

    return Scope:Frame {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 30), -- Each item height
        [Fusion.Children] = {
            Scope:SwitchInput {
                Size = UDim2.new(0, 30, 0, 10), -- Checkbox size
                CornerRadius = UDim.new(0,0),
                StrokeColor = Color3.fromRGB(0,255,0),
                StrokeThickness = .5,
                Position = UDim2.new(0, 0, 0, key * 40),
                Switched = switchValue,
                OnActivated = function()
                    onOptionChange(key)
                end
            },
            Scope:Text {
                Text = text,
                Size = UDim2.new(1, 0, 1, 0), -- Adjust width for text
                Position = UDim2.new(0, 50, 0, key * 40),
                TextSize = 12,
                BackgroundTransparency = 1,
                TextColor3 = Util.Colors.Green["950"]
            }
        }
    }

end
