local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local Toolbar = require(script.Parent.Parent.components.Toolbar)
local ItemsBag = require(script.Parent.Parent.components.ItemsBag)
local SelectBox = require(script.Parent.Parent.components.SelectBox)
local SelectTextBox = require(script.Parent.Parent.components.SelectTextBox)


return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
    local peek = Fusion.peek
    local MyScope = Scope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.storeRef
    local toolSelected = store.toolSelected
    local toolSelectedObs = store.toolSelectedObs
    local toolStateSelection = store.toolStateSelection
    print("toolStateSelection ", toolStateSelection)

    local leftToolbar = Toolbar(Scope, {  
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10),
        Size = UDim2.new(0, 10, 0, 130),
        Position = UDim2.new(0, 0, 0, 0),
        a = Scope:Computed(function(use,scope)
            return "use(toolSelected)" .. " "
        end),
        toolSelectedObs = toolSelectedObs,
        toolSelected =  toolSelected,
        OnActivated = function(idTool)
            print("apple clicked")
            toolSelected:set(idTool)

            if idTool == 1 then
                toolStateSelection.appleSelected:set(true)
                toolStateSelection.pearSelected:set(false)
                toolStateSelection.bananaSelected:set(false)            
            elseif idTool == 2 then
                toolStateSelection.appleSelected:set(false)
                toolStateSelection.pearSelected:set(true)
                toolStateSelection.bananaSelected:set(false)
            elseif idTool == 3 then
                toolStateSelection.appleSelected:set(false)
                toolStateSelection.pearSelected:set(false)
                toolStateSelection.bananaSelected:set(true)
            end
            
        end,
        toolStateSelection = toolStateSelection
    })

    
    toolSelectedObs:onChange(function()
        print("__ : ", peek(toolSelected))
        --[[ textLabel.Text = "Hello World! " .. peek(nTimesOpen) ]]
    end)
    


    local text1 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 1", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

     local text2 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 2", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

    local text3 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 3", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

    local text4 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 4", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

    local text5 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 5", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

    local text6 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 6", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }
     local selectTextBox = SelectTextBox(Scope, {
        Items = { text1, text2, text3, text4, text5  },        
        Width = 100,
        Height = 100

     })


    local parentFrame = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(0, 200, 1, 0),
        Position = UDim2.new(0, 50, 0, 50),
        BackgroundColor3 = Util.Colors.Gray["300"]
	}

    selectTextBox.Parent = parentFrame

    return parentFrame
    
end
--[[ 

local frameUp = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .5, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Yellow["100"]
	}
    
    local frameDown =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, .5, 0),
        Position = UDim2.new(0, 0, .5, 0),
        BackgroundColor3 = Util.Colors.Emerald["300"]
	}

    local frameLeft = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Indigo["100"]
	}
    
    local frameRight =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(.5, 0, 1, 0),
        Position = UDim2.new(0.5, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Amber["300"]
	}

    local parentFrame = Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    if Props.Show then
        frameLeft.Parent = frameUp
        frameRight.Parent = frameUp

        Props.LeftComponent.Parent = frameLeft
        Props.RightComponent.Parent = frameRight
        Props.BottomComponent.Parent = frameDown

        frameUp.Parent = parentFrame
        frameDown.Parent = parentFrame
    end

	return parentFrame
]]