local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local StepTemplate = require(script.Parent.Parent.templates.StepTemplate)
local GreetText = require(script.Parent.Parent.components.GreetText)
local ButtonGo = require(script.Parent.Parent.components.ButtonGo)
local FruitButtons = require(script.Parent.Parent.components.FruitButtons)
local FruitImage = require(script.Parent.Parent.components.FruitImage)

return function(Scope: Fusion.Scope<any>, Props)    
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.storeRef
    local fruitSelected = store.fruitSelected
    local router = Props.routerRef


    local title = GreetText(Scope, {
        greetMsg = "Step number 1"
    })

    local fruitButtons = FruitButtons (Scope, {
        OnActivatedApple = function()
            print("apple clicked")
            fruitSelected:set("Apple")
        end,
        OnActivatedPear = function()
            print("pear clicked")
            fruitSelected:set("Pear")
        end,
        OnActivatedBanana = function()
            print("banana clicked")
            fruitSelected:set("Banana")
        end
    })

    

    local fruitImage = FruitImage(Scope, {
        fruitTitle = Scope:Computed(function(use, scope)
            return "Fruit_ : " .. use(fruitSelected)
        end),
        fruitImage = Scope:Computed(function(use, scope)
            local assetId = "none"
            if use(fruitSelected) == "Apple" then
                assetId = "396952879"
            elseif use(fruitSelected) == "Pear" then
                assetId = "6688070218"
            elseif use(fruitSelected) == "Banana" then
                assetId = "12825469459"
            end
            return "rbxassetid://" .. assetId
        end)
    })

    local buttonNext = ButtonGo(Scope, { Text="Next _" ,
    Size = UDim2.new(0.25, 0, .25, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        print("Clicked")
    end})
    
    local mainSection = StepTemplate(Scope, { Title = title,  Left = fruitButtons, Right = fruitImage, Footer = buttonNext})

	return mainSection
end
