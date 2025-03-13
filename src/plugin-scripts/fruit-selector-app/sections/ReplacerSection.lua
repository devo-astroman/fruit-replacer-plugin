local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local Toolbar = require(script.Parent.Parent.components.Toolbar)
local ItemsBag = require(script.Parent.Parent.components.ItemsBag)
local SelectBox = require(script.Parent.Parent.components.SelectBox)


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

    local itemsBag = ItemsBag(Scope, {
        Items = { "line1", "line2", "line3" }
     })

     local tempFrame = Scope:Frame {
		CornerRadius = UDim.new(0,0),
        Size = UDim2.new(0, 400, 0, 20),
        Padding = 0,
        Content = {"button1"},
        ContentWrapped = true,
        ContentSize = 9,
        OnActivated = function()
            print("clicked 1")
        end,
	}

     local btn1 = Scope:Button {
        CornerRadius = UDim.new(0,0),
        Size = UDim2.new(1, 0, 0, 30),
        Padding = 0,
        Content = {"button1"},
        ContentWrapped = true,
        ContentSize = 9,
        OnActivated = function()
            print("clicked 1")
        end,
    }

    

    local btn2 = Scope:Button {
        CornerRadius = UDim.new(0,0),
        Size = UDim2.new(1, 0, 0, 20),
        Padding = 0,
        Content = {"button2"},
        ContentWrapped = true,
        ContentSize = 9,
        OnActivated = function()
            print("clicked 2")
        end,
    }


    local text1 = Scope:Text { 
        Text = "Item1", 
        Size = UDim2.new(.5, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,
        TextXAlignment = Enum.TextXAlignment.Center,
        TextColor3 = Util.Colors.Stone["950"],
    }

     local text2 = Scope:Text { Text = "Item2", Size = UDim2.new(1, 0, 0, 30),
    BackgroundColor3 = Util.Colors.Green["200"],
BackgroundTransparency = 0 }
     local text3 = Scope:Text { Text = "Item3", Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Util.Colors.Blue["500"],
BackgroundTransparency = 0 }
     local text4 = Scope:Text { Text = "Item4", Size = UDim2.new(1, 0, 0, 40),
    BackgroundColor3 = Util.Colors.Red["200"],
BackgroundTransparency = 0 }
     local text5 = Scope:Text { Text = "Item5", Size = UDim2.new(1, 0, 0, 35),
    BackgroundColor3 = Util.Colors.Green["200"],
BackgroundTransparency = 0 }
     local text6 = Scope:Text { Text = "Item6", Size = UDim2.new(1, 0, 0, 50),
    BackgroundColor3 = Util.Colors.Blue["200"],
BackgroundTransparency = 0 }

     local selectBox = SelectBox(Scope, {
        Items = { text1, btn1, text3, text4, btn2, text6  }
        --[[ Items = { btn1, text1, btn2  } ]]
     })


    local parentFrame = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Blue["700"]
	}

    selectBox.Parent = parentFrame

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