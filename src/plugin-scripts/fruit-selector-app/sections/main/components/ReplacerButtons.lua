local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)


return function(Scope: Fusion.Scope<any>, Props)
    local Util = OnyxUI.Util
    local InnerScope = Fusion.innerScope
    local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.Store

    local available = Props.available or false
    local onAppleActivated = Props.onAppleActivated or function() end
    local onPearActivated = Props.onPearActivated or function() end
    local onBananaActivated = Props.onBananaActivated or function() end

    local sizeX = 20
    local sizeY = sizeX
    local posX = 30
    -- ✅ Create buttons with proper spacing
    local appleButton = Scope:IconButton {
        CornerRadius = UDim.new(0,2),
        Padding = 0,
        Image = "rbxassetid://4800956040", -- Replace with actual Apple icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*0, 0, 0),
        Disabled = not available,
        OnActivated = onAppleActivated
    }

    local pearButton = Scope:IconButton {
        CornerRadius = UDim.new(0,2),
        Padding = 0,
        Image = "rbxassetid://13789464687", -- Replace with actual Pear icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*1, 0, 0),
        Disabled = not available,
        OnActivated = onPearActivated
    }

    local bananaButton = Scope:IconButton {
        CornerRadius = UDim.new(0,2),
        Padding = 0,
        Image = "rbxassetid://12825469459", -- Replace with actual Banana icon asset ID
        Size = UDim2.new(0, sizeX, 0, sizeY),
        Position = UDim2.new(0, posX*2, 0, 0),
        Disabled = not available,
        OnActivated = onBananaActivated
    }

    -- ✅ Parent frame containing the buttons
    local parentFrame = Scope:Frame {
        BackgroundTransparency = 1,
        --[[ Size = UDim2.new(0, 180, 0, 60), -- Adjusted width for three buttons (3 * 60) ]]
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"],
        AutomaticSize = Enum.AutomaticSize.XY,
        [Fusion.Children] = { appleButton, pearButton, bananaButton }
    }

    return parentFrame
end
