local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local constants = require(script.Parent.Parent.constants)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Themer = OnyxUI.Themer
    local peek = Fusion.peek
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
	local Theme = Themer.Theme:now()
    local idSelectedTool = Props.a
    local toolSelected = Props.toolSelected
    local toolStateSelection = Props.toolStateSelection

    print("2 toolStateSelection ", toolStateSelection)    



	local button1 = Scope:IconButton {
        --[[ IsHolding = peek(Props.AppleSelected), ]]
        --[[ IsHolding = Scope:Computed(function(use, scope)
            print("flag ", use(Props.SelectedTool))
            return constants.tools.apple.id == use(Props.SelectedTool)
        end), ]]

        Padding = 0,
        Size = UDim2.new(1,0,.25,0),
        Position = UDim2.new(0,0,0,0),
        --[[ Content = {constants.tools.apple.text}, ]]
        Image = constants.tools.apple.image,
        OnActivated = function()            
           Props.OnActivated(constants.tools.apple.id) 
        end,
        Disabled = peek(toolSelected) == 1
        --[[ Disabled = toolStateSelection.appleSelected, ]]        
        --[[ IsHolding = peek(toolStateSelection.appleSelected), ]]
--[[         Content = Scope:Computed(function(use,scope)
            if(use(toolStateSelection.appleSelected)) then
                return {"T"}
            else
                return {"F"}
            end
        end) ]]
    }

    local button2 = Scope:IconButton {
        --[[ IsHolding = Props.SelectedTool == constants.tools.pear.id, ]]
        Size = UDim2.new(1,0,.25,0),
        Position = UDim2.new(0,0,.33,0),
        --[[ Content = {constants.tools.pear.text}, ]]
        Image = constants.tools.pear.image,
        OnActivated = function()
           Props.OnActivated(constants.tools.pear.id) 
        end,
        Disabled = peek(toolSelected) == 2
        --[[ Disabled = toolStateSelection.pearSelected, ]]
    }

    local button3 = Scope:IconButton {
        --[[ IsHolding = Props.SelectedTool == constants.tools.banana.id, ]]
        Size = UDim2.new(1,0,.25,0),
        Position = UDim2.new(0,0,.66,0),
        --[[ Content = {constants.tools.banana.text}, ]]
        Image = constants.tools.banana.image,
        OnActivated = function()            
           Props.OnActivated(constants.tools.banana.id) 
        end,
        Disabled = peek(toolSelected) == 3
        --[[ Disabled = toolStateSelection.bananaSelected, ]]
    }

    local frameParent = Scope:Frame {
        PaddingLeft = Props.PaddingLeft,
        PaddingTop = Props.PaddingTop,
		BackgroundTransparency = 1,
        Size = Props.Size,
        Position = Props.Position,
        BackgroundColor3 = Util.Colors.Red["100"]
	}

    button1.Parent = frameParent
    button2.Parent = frameParent
    button3.Parent = frameParent


	return frameParent
end