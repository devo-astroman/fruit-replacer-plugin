local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local MainTemplate = require(script.Parent.Parent.templates.MainTemplate)
local GreetText = require(script.Parent.Parent.components.GreetText)
local ButtonGo = require(script.Parent.Parent.components.ButtonGo)

return function(Scope: Fusion.Scope<any>, Props)    
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.storeRef
    local fruitSelected = store.fruitSelected
    local router = Props.routerRef

    local greetText = GreetText(Scope, {
        greetMsg = "FRUIT SELECTOR"
    }) 

    local buttonGo = ButtonGo(Scope, { Text="Go to Editor" ,
    Size = UDim2.new(0.25, 0, .25, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        router.goToSection("editor")
    end})

    local buttonA = ButtonGo(Scope, { Text="A Button" , 
    Size = UDim2.new(0.25, 0, .25, 0),
     Position = UDim2.new(0, 0, .5, 0),
    OnActivated = function()
        store.fruitSelected:set("Fruit A")
    end}) 

    local buttonB = ButtonGo(Scope, { Text="B Button" , 
    Size = UDim2.new(0.25, 0, .25, 0),
     Position = UDim2.new(0, 0, .75, 0),
    OnActivated = function()
        store.fruitSelected:set("Fruit B")
    end}) 

    local frame =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Emerald["300"]
	}
    buttonGo.Parent = frame
    buttonA.Parent = frame
    buttonB.Parent = frame

    local finalMsg = Scope:Computed(function(use, scope)
        return use(fruitSelected) .. " have been selected"
    end)

    local greetText3 = GreetText(Scope, {
        greetMsg = finalMsg,
    })

 

    
    local mainSection = MainTemplate(Scope, { LeftComponent = greetText,  RightComponent = frame, BottomComponent = greetText3, Show = true})

	return mainSection
end