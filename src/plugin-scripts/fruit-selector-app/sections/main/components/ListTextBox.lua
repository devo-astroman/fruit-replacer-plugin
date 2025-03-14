local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Themer = OnyxUI.Themer
    local peek = Fusion.peek
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local Theme = Themer.Theme:now()

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

    print("table - ", textElements)
    print("items - ", items)
    
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
        AutomaticSize = Enum.AutomaticSize.Y -- ✅ Auto-adjust height based on children

    }

    -- ✅ Loop through each item and dynamically position them based on previous elements
    local totalHeight = 0 -- ✅ Tracks total height of all items
    local currentY = 0 -- ✅ Tracks the Y position for each element
    
    for i, item in ipairs(items) do
        if item.Size and item.Size.Y then            
            local itemSizeY = item.Size.Y.Offset -- ✅ Get the item's height dynamically
            
            item.Size = UDim2.new(0, width, 0, itemSizeY) -- ✅ Position based on accumulated height
            item.Parent = listFrame
            item.Position = UDim2.new(0, 0, 0, currentY) -- ✅ Position based on accumulated height
            
            currentY = currentY + itemSizeY -- ✅ Update for the next element
            totalHeight = totalHeight + itemSizeY -- ✅ Accumulate total height
        else
            warn("Item at index " .. i .. " has no valid Size.Y property.")
        end
    end

    local scrollerParent = Scope:Scroller {
		BackgroundTransparency = 0,
        Size = UDim2.new(1,0,0,height),
        CanvasSize = UDim2.new(1,0,0,totalHeight),
        Position = UDim2.new(0,0,0,0),
        BackgroundColor3 = Util.Colors.Emerald["800"]
	}

    if totalHeight > height then    
        scrollerParent.Parent = parentFrame
        listFrame.Parent = scrollerParent
    else
        listFrame.Parent = parentFrame
    end

    

    return parentFrame
end

