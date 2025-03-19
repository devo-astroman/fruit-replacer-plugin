local Fusion = require(script.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step1 = require(script.Parent.steps.Step1)
local Step2 = require(script.Parent.steps.Step2)
local Step3 = require(script.Parent.steps.Step3)

local MainTemplate = require(script.Parent.MainTemplate)

return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)    

    local step1 =  Step1(Scope, {
        StoreRef = Props.StoreRef
    })

    local step2 =  Step2(Scope, {
        StoreRef = Props.StoreRef
    })
    
    local step3 =  Step3(Scope, {
        StoreRef = Props.StoreRef,
        Controller = Props.ControllerRef
    })

    local main =   MainTemplate(Scope, {
        LeftComponent = step1,
        MiddleComponent = step2,
        RightComponent = step3,
        
    })

	return main
end
