local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Themer = OnyxUI.Themer
	local Theme = Themer.Theme:now()
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.Store

    local height = Props.Height
    local width = Props.Width

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,width,0, height),
        Position = Props.Position,
        BackgroundColor3 =  Scope:Computed(function(use)
			return use(Theme.Colors.Neutral.Main)
		end),
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
                    local sY =10
                    local size = UDim2.new(1, 0, 0, 5) -- ✅ Position based on accumulated height                    
                    local position = UDim2.new(0, 0, 0, (i-1)*20) -- ✅ Position based on accumulated height

                    local textComponent = Scope:Text {
                        PaddingTop = UDim.new(0,5),
                        Text = element.Name, -- ✅ Set the element name
                        Size = size,
                        Position = position,
                        BackgroundColor3 = Scope:Computed(function(use)
                            return use(Theme.Colors.Neutral.Dark)
                        end),
                        BackgroundTransparency = 0,
                        TextSize = 9,
                        TextColor3 = Scope:Computed(function(use)
                            return use(Theme.Colors.NeutralContent.Main)
                        end),
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
        BackgroundColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Neutral.Dark)
		end),
        ScrollBarImageColor3 = Scope:Computed(function(use)
			return use(Theme.Colors.Neutral.Light)
		end),
	}

    scrollerParent.Parent = parentFrame
    listFrame.Parent = scrollerParent    

    return parentFrame
end
