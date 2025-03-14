local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step1Template = require(script.Parent.Step1Template)

local StepTitle = require(script.Parent.Parent.components.StepTitle)
local ListTextBox = require(script.Parent.Parent.components.ListTextBox)


return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local Util = OnyxUI.Util

    local title =   StepTitle(Scope, {
        Instruction = "Select the items to be replaced",
        NStep = 1,
        Position =  UDim2.new(0,0,0,0),
        Size =  UDim2.new(1,0,0,0)
    })

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

    local text7 = Scope:Text { 
        PaddingTop = UDim.new(0,5),
        Text = "Item 7", 
        Size = UDim2.new(1, 0, 0, 20),
        BackgroundColor3 = Util.Colors.Stone["50"],
        BackgroundTransparency = 0,
        TextSize = 9,        
        TextColor3 = Util.Colors.Stone["950"],
    }

    local listTextBox = ListTextBox(Scope, {
        Items = { text1, text2, text3, text4, text5, text6, text7  },        
        Width = 100,
        Height = 100,
        Position =  UDim2.new(0,0,0,0)
     })


    local step =  Step1Template(Scope, {
        Title = title,
        ListTextBox = listTextBox
    })

    return step

end
