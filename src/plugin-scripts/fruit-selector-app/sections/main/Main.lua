local Fusion = require(script.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step1 = require(script.Parent.steps.Step1)
local MainTemplate = require(script.Parent.MainTemplate)


return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)

    local step1 =  Step1(Scope, {})
    print("step1Section ", step1)

    local main =   MainTemplate(Scope, {
        LeftComponent = step1,
        --[[ MiddleComponent = step1Section,
        RightComponentComponent = step1Section, ]]
        
    })

    --[[ return step1Section ]]
	return main
end
