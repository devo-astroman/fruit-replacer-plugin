local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Themer = OnyxUI.Themer
    local Theme = Themer.Theme:now()
    local InnerScope = Fusion.innerScope
    local Util = OnyxUI.Util
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.Store
    local peek = Fusion.peek

    local disabled = Props.Disabled
    
    local onAppleActivated = Props.onAppleActivated or function() end
    local onPearActivated = Props.onPearActivated or function() end
    local onBananaActivated = Props.onBananaActivated or function() end

    local sizeX = 35
    local sizeY = 15
    local posX = sizeX + 1
    -- ✅ Create buttons with proper spacing
    local appleButton = Scope:IconButton {    
        StrokeThickness = 1,
        StrokeEnabled = false,
        CornerRadius = UDim.new(0,0),
        Padding = 0,
        Disabled = disabled,
        OnActivated = onAppleActivated,
        Image = "rbxassetid://101980888457907", -- Replace with actual Apple icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*0, 0, 0),
    }

    local pearButton = Scope:IconButton { 
        StrokeThickness = 1,
        StrokeEnabled = false,
        CornerRadius = UDim.new(0,0),
        Padding = 0,
        Disabled = disabled,
        OnActivated = onPearActivated,
        Image = "rbxassetid://80401381264733", -- Replace with actual Apple icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*1, 0, 0),
    }

    local bananaButton = Scope:IconButton {  
        StrokeThickness = 1,
        StrokeEnabled = false,
        CornerRadius = UDim.new(0,0),
        Padding = 0,
        Disabled = disabled,
        OnActivated = onBananaActivated,
        Image = "rbxassetid://138840669658788", -- Replace with actual Apple icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*2, 0, 0),
    }
    
    -- ✅ Parent frame containing the buttons
    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        --[[ Size = UDim2.new(0, 180, 0, 60), -- Adjusted width for three buttons (3 * 60) ]]
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.XY,
        [Fusion.Children] = { appleButton, pearButton, bananaButton,  }
    }

    return parentFrame
end
