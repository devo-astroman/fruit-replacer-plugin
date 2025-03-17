local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.Store

    local textElements = Props.TextElements
    local items = {}
    for _, element in ipairs(textElements) do
        local textComponent = Scope:Text {
            PaddingTop = UDim.new(0,5),
            Text = element, -- ✅ Set the element name
            Size = UDim2.new(1, 0, 0, 20),
            BackgroundColor3 = Util.Colors.Stone["50"],
            BackgroundTransparency = 0,
            TextSize = 9,        
            TextColor3 = Util.Colors.Stone["950"],
        }
        table.insert(items, textComponent)
    end
    
    local height = Props.Height
    local width = Props.Width

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,width,0, height),
        --[[ Position = UDim2.new(0,0,0,0), ]]
        Position = Props.Position,
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    -- ✅ Parent frame with automatic height adjustment
    local listFrame = Scope:Frame {
        BackgroundTransparency = 0, 
        Size = UDim2.new(1, 0, 0, 0), -- Height will adjust dynamically
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.Y,
        [Fusion.Children] = Scope:Computed(function(use)
            local components = {}            
            for i, element in ipairs(use(store.selectedElements)) do

                if element.Size and element.Size.Y then
                    
                    local size = UDim2.new(1, 0, 0, 20) -- ✅ Position based on accumulated height                    
                    local position = UDim2.new(0, 0, 0, (i-1)*20) -- ✅ Position based on accumulated height

                    local textComponent = Scope:Text {
                        PaddingTop = UDim.new(0,5),
                        Text = element.Name, -- ✅ Set the element name
                        Size = size,
                        Position = position,
                        BackgroundColor3 = Util.Colors.Stone["50"],
                        BackgroundTransparency = 0,
                        TextSize = 9,        
                        TextColor3 = Util.Colors.Stone["950"],
                    }
                    table.insert(components, textComponent)

                else
                    warn("Item at index " .. i .. " has no valid Size.Y property.")
                end
            end
            return components
        end)
    }

    -- ✅ Loop through each item and dynamically position them based on previous elements
    local totalHeight = 0 -- ✅ Tracks total height of all items

    local scrollerParent = Scope:Scroller {
		BackgroundTransparency = 0,
        Size = UDim2.new(1,0,0,height),
        CanvasSize = UDim2.new(1,0,0,totalHeight),
        Position = UDim2.new(0,0,0,0),
        BackgroundColor3 = Util.Colors.Emerald["800"]
	}

    scrollerParent.Parent = parentFrame
    listFrame.Parent = scrollerParent    

    return parentFrame
end
