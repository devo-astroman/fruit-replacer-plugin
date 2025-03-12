local Fusion = require(script.Parent.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.Parent.packages.OnyxUI)
local StepTemplate = require(script.Parent.Parent.templates.StepTemplate)
local GreetText = require(script.Parent.Parent.components.GreetText)
local ButtonGo = require(script.Parent.Parent.components.ButtonGo)
local ReplacerPane = require(script.Parent.Parent.components.ReplacerPane)
local ReplacerInfo = require(script.Parent.Parent.components.ReplacerInfo)

local Selection = game:GetService("Selection")
local Workspace = game:GetService("Workspace")


return function(Scope: Fusion.Scope<any>, Props)    
	local Util = OnyxUI.Util
	local InnerScope = Fusion.innerScope
	local Scope = InnerScope(Scope, Fusion, OnyxUI.Util, OnyxUI.Components)
    local store = Props.storeRef
    local fruitSelected = store.fruitSelected
    local modelLoaded = store.modelLoaded
    local elementsSelected = store.elementsSelected
    local router = Props.routerRef
    local peek = Fusion.peek


    local title = GreetText(Scope, {
        greetMsg = "Step number 2"
    })

    local replacerPane = ReplacerPane (Scope, {
        OnActivatedSelect = function()            
            local elems = {}
            for _, object in pairs(Selection:Get()) do
                if object:IsA("BasePart") then
                    table.insert(elems, object) 
                    print("select ", object)
                end
            end
            elementsSelected:set(elems)
        end,
        OnActivatedReplace = function()            
            for _, object in pairs(peek(elementsSelected)) do
                if object:IsA("BasePart") then -- Ensure object is a valid part
                    local fruitModel = peek(modelLoaded):Clone() -- ✅ Fix cloning syntax
                    
                    -- ✅ Ensure the Model has a PrimaryPart
                    if fruitModel:IsA("Model") and fruitModel.PrimaryPart then
                        fruitModel:SetPrimaryPartCFrame(object.CFrame) -- ✅ Position model at part
                    else
                        warn("fruitModel does not have a PrimaryPart!")
                    end
        
                    fruitModel.Parent = object.Parent -- ✅ Set the parent
                    object.Transparency = 1
        
                    print("Placed:", object.Name)
                else
                    warn("Object is not a BasePart:", object)
                end
            end            
        end
        
    })

    

    local replacerInfo = ReplacerInfo(Scope, {
        fruitTitle = Scope:Computed(function(use, scope)
            return "Fruit: " .. use(fruitSelected)
        end),
        elementsSelected = Scope:Computed(function(use, scope)
            local result = ""
            for _, object in pairs(use(elementsSelected)) do
                if object:IsA("BasePart") then
                    result = result .. " " .. object.Name .. "\n"
                end
            end

            return result
        end)
    })

    local buttonsParent = Scope:Frame {
		BackgroundTransparency = 1,
        Size = UDim2.new(.5, 0, .25, 0),
        Position = UDim2.new(.25, 0, 0, 0),
        BackgroundColor3 = Util.Colors.Red["100"]
	}

    local buttonBack = ButtonGo(Scope, { Text="Back" ,
    Size = UDim2.new(0.5, 0, 1, 0),
     Position = UDim2.new(0, 0, 0, 0),
     OnActivated = function()
        Props.goToSelector()
    end})

    local buttonNext = ButtonGo(Scope, { Text="Next" ,
    Size = UDim2.new(0.5, 0, 1, 0),
     Position = UDim2.new(0.5, 0, 0, 0),
     OnActivated = function()
        Props.goToCreator()
    end})

    buttonBack.Parent = buttonsParent
    buttonNext.Parent = buttonsParent
    
    local mainSection = StepTemplate(Scope, { Title = title,  Left = replacerPane, Right = replacerInfo, Footer = buttonsParent})

	return mainSection
end
