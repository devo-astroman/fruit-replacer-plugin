local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local MainTemplate = require(script.Parent.Parent.templates.MainTemplate)
local GreetText = require(script.Parent.Parent.components.GreetText)

return function(Scope: Fusion.Scope<any>, Props)
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    
    local greetText = GreetText(Scope, {
        greetMsg = "CREATOR EDITOR"
    }) 

    local greetText2 = GreetText(Scope, {
        greetMsg = "Go to about",        
    }) 

    local greetText3 = GreetText(Scope, {
        greetMsg = "Very cool!",
    })

    
    local mainSection = MainTemplate(Scope, { LeftComponent = greetText,  RightComponent = greetText2, BottomComponent = greetText3, Show = true})
    print("mainSection ", mainSection)
    

	return mainSection
end