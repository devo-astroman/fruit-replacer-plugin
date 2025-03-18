local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step2Template = require(script.Parent.Step2Template)

local StepTitle = require(script.Parent.Parent.components.StepTitle)
local ReplacerButtons = require(script.Parent.Parent.components.ReplacerButtons)
local OptionsList = require(script.Parent.Parent.components.ListOptions)

return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local Util = OnyxUI.Util
    local peek = Fusion.peek
    local store = Props.StoreRef

    local title =   StepTitle(Scope, {
        Instruction = "Select the replacer item",
        NStep = 1,
        Position =  UDim2.new(0,0,0,0),
        Size =  UDim2.new(1,0,0,0)
    })

    local replacerButtons = ReplacerButtons(Scope, {
        available = true,
        onAppleActivated = function() print("Apple button clicked!") end,
        onPearActivated = function() print("Pear button clicked!") end,
        onBananaActivated = function() print("Banana button clicked!") end
     })

     local optionsTitle =   StepTitle(Scope, {
        Instruction = "Options:",
        NStep = 1,
        Position =  UDim2.new(0,0,0,0),
        Size =  UDim2.new(1,0,0,0)
    })
    
    local value1 = store.options.delete
    local value2 = store.options.orientation
    local value3 = store.options.scale
    local value4 = store.options.confirm
    local function handleOptionChange(key)
        local value = store.options[key];
        value:set(not(peek(value)))
    end

    local optionsList =  OptionsList(Scope, {       
        OnOptionChange = handleOptionChange,
        Value1 = {key = "delete", value = value1},
        Value2 = {key = "orientation", value = value2},
        Value3 = {key = "scale", value = value3},
        Value4 = {key = "confirm", value = value4},
    })


    local step =  Step2Template(Scope, {
        Title = title,
        ReplacerButtons = replacerButtons,
        OptionsTitle = optionsTitle,
        Options = optionsList
    })

    return step

end
