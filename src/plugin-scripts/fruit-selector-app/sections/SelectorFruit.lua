local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local MainTemplate = require(script.Parent.Parent.templates.MainTemplate)
local GreetText = require(script.Parent.Parent.components.GreetText)
local ButtonGo = require(script.Parent.Parent.components.ButtonGo)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local router = Props.routerRef

    local greetText = GreetText(Scope, {
        greetMsg = "FRUIT SELECTOR"
    }) 

    local buttonGo = ButtonGo(Scope, {OnActivated = function()
        router.goToSection("editor")
    end}) 

    local greetText3 = GreetText(Scope, {
        greetMsg = "Very cool!",
    })

    
    local mainSection = MainTemplate(Scope, { LeftComponent = greetText,  RightComponent = buttonGo, BottomComponent = greetText3, Show = true})

	return mainSection
end