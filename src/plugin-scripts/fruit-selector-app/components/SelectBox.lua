local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local constants = require(script.Parent.Parent.constants)


--[[ Component: SelectBox ]]
return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Themer = OnyxUI.Themer
    local peek = Fusion.peek
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local Theme = Themer.Theme:now()

    local items = Props.Items or {} -- Default to empty table if nil

    -- ✅ Parent frame with automatic height adjustment
    local listFrame = Scope:Frame {
        BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 0, 0), -- Height will adjust dynamically
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.Y -- ✅ Auto-adjust height based on children

    }

    -- ✅ Loop through each item and dynamically position them based on previous elements
    local currentY = 0 -- Tracks the Y position for each element
    for i, item in ipairs(items) do
        if item.Size and item.Size.Y then
            local itemSizeY = item.Size.Y.Offset -- ✅ Get the item's height dynamically
            
            item.Parent = listFrame
            item.Position = UDim2.new(0, 0, 0, currentY) -- ✅ Position based on accumulated height
            currentY = currentY + itemSizeY -- ✅ Update for the next element
        else
            warn("Item at index " .. i .. " has no valid Size.Y property.")
        end
    end

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,300,0,120),
        Position = UDim2.new(0,10,0,10),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    local scrollerParent = Scope:Scroller {
		BackgroundTransparency = 0,
        Size = UDim2.new(1,0,1,0),
        Position = UDim2.new(0,0,0,0),
        BackgroundColor3 = Util.Colors.Green["700"]
	}

    scrollerParent.Parent = parentFrame
    listFrame.Parent = scrollerParent

    return parentFrame
end




--[[ 
return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,400,0,100),
        Position = UDim2.new(0,10,0,10),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    local scroller = Scope:Scroller {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,200,0,300),
        Position = UDim2.new(0,10,0,10),
        BackgroundColor3 = Util.Colors.Green["700"]
	}

    local innerFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(0,200,0,500),
        Position = UDim2.new(0,10,0,10),
        BackgroundColor3 = Util.Colors.Red["700"]
	}

    innerFrame.Parent = scroller
    scroller.Parent = parentFrame


	return parentFrame
end  ]]

--[[ return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
    local peek = Fusion.peek
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()
    
    

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(0,100,0,20),
        Position = UDim2.new(0,10,0,10),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    local scrollFrame = Scope:Scroller {
        ScrollingDirection =  Enum.ScrollingDirection.Y,
        ScrollingEnabled = true
	}

    local items = Props.Items
    local customText = 
    [[
This a text line 1
This a text line 2
This a text line 3
This a text line 4
This a text line 5
This a text line 6
This a text line 7
This a text line 8
    ] ]

    local textArea = Scope:TextArea{
        MultiLine = true,
        TextEditable = false,
        TextSize = 10,
        Size = UDim2.new(0,100,0,50),
        Position = UDim2.new(0,10,0,10),
        Text = customText,
        ScrollingEnabled = true
    }

    --[[ textArea.Parent = parentFrame
    scrollFrame.Parent = parentFrame
 ] ]

    local scrollFrame = Scope:ScrollingFrame {
        Size = UDim2.new(0, 150, 0, 100), -- Adjusted for scrolling
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 0,
        CanvasSize = UDim2.new(0, 0, 1, 300), -- Extend scrolling area
        ScrollBarThickness = 5, -- Thickness of the scrollbar
        AutomaticCanvasSize = Enum.AutomaticSize.Y -- Automatically resize
    }

    textArea.Parent = scrollFrame
    scrollFrame.Parent = parentFrame



	return parentFrame
end ]]