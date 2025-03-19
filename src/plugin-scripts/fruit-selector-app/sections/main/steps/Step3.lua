local Fusion = require(script.Parent.Parent.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.Parent.Parent.packages.OnyxUI)

local Step3Template = require(script.Parent.Step3Template)

local StepTitle = require(script.Parent.Parent.components.StepTitle)
local CompleteMessage = require(script.Parent.Parent.components.CompleteMessage)
local ConfirmMessage = require(script.Parent.Parent.components.ConfirmMessage)

return function(Scope: Fusion.Scope<any>, Props)	
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.StoreRef
    local controller = Props.Controller

    local title =   StepTitle(Scope, {
        Instruction = "Result",
        NStep = 3,
        Position =  UDim2.new(0,0,0,0),
        Size =  UDim2.new(1,0,0,0)
    })

    local completeMessage = CompleteMessage(Scope, {
        Message = "Replacement complete",
    })

    local confirmMessage = ConfirmMessage(Scope, {
        Message = "Do you confirm the replacement?",
        OnAnswer = function(response)
            if response then
                print("Should complete the operation")
                controller.Confirm()
            else
                print("Should cancel the operation")
                controller.Cancel()
            end
        end
    })

    local step =  Step3Template(Scope, {
        Title = title,
        CompleteMessage = completeMessage,
        ConfirmMessage = confirmMessage,
        ShowConfirm = store.showConfirm,
        ShowComplete = store.showComplete
    })

    return step

end
