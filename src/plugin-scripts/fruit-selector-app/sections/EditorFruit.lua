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
    
    local buttonGo = ButtonGo(Scope, { Text="Go to Selector" ,
    Size = UDim2.new(0.25, 0, .25, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        router.goToSection("selector")
    end})
     
    local greetText = GreetText(Scope, {
        greetMsg = "FRUIT EDITOR"
    }) 

    local greetText2 = GreetText(Scope, {
        greetMsg = "Go to about",        
    }) 

    local finalMsg = Scope:Computed(function(use, scope)
        return "From editor: " .. use(fruitSelected) .. " have been selected"
    end)

    local greetText3 = GreetText(Scope, {
        greetMsg = finalMsg,
    })

    local frame =  Scope:Frame {
		BackgroundTransparency = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Emerald["300"]
	}
    buttonGo.Parent = frame
    
    local mainSection = MainTemplate(Scope, { LeftComponent = greetText,  RightComponent = frame , BottomComponent = greetText3, Show = true})
    

	return mainSection
end