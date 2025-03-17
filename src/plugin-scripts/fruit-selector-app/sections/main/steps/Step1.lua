local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step1Template = require(script.Parent.Step1Template)

local StepTitle = require(script.Parent.Parent.components.StepTitle)
local ListTextBox = require(script.Parent.Parent.components.ListTextBox)

return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local Util = OnyxUI.Util
    local peek = Fusion.peek
    local store = Props.StoreRef

    local title =   StepTitle(Scope, {
        Instruction = "Select the items to be replaced",
        NStep = 1,
        Position =  UDim2.new(0,0,0,0),
        Size =  UDim2.new(1,0,0,0)
    })

    local listTextBox = ListTextBox(Scope, {
        TextElements =  Scope:Computed(function(Use)
            local textElements = {}
            for index = 1, Use(store.nSelectedElements) do
                table.insert(textElements, "Text " .. index)
            end            
            return textElements
        end),  
        Width = 100,
        Height = 100,
        Position =  UDim2.new(0,0,0,0),
        HeaderText = Scope:Computed(function()
            return "my text"
        end),
        Store = store
     })


    local step =  Step1Template(Scope, {
        Title = title,
        ListTextBox = listTextBox
    })

    return step

end
