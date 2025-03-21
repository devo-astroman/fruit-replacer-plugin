local loadEmbeddedModel = require(script.Parent.Parent.utils.EmbeddedAssetLoader)

local storeManager = nil
local Selection = game:GetService("Selection")

-- Table to store selected elements
local selectedElements = {}
local ChangeHistoryService = game:GetService("ChangeHistoryService")

local undoStack = {}
local controller = {}

local conn1 = nil
local conn2 = nil
function controller.init(pluginRef, storeManagerRef)
   storeManager = storeManagerRef

  ChangeHistoryService.OnUndo:Connect(function(value)
    if(value == "Elements Replaced") then
        Selection:Set({})
    end
  end)

end
function controller.run()
   local store = storeManager.getStore()   
   conn1 = Selection.SelectionChanged:Connect(function()
    local selected = Selection:Get() -- Get currently selected objects
    selectedElements = {} -- Reset table

    for _, object in pairs(selected) do
        if object:IsA("BasePart") then 
            table.insert(selectedElements, object)
        end
    end

    if #selectedElements > 0 then
        store.showComplete:set(false)
    else
        store.replacerElement:set(0)
        store.showConfirm:set(false)
    end
    storeManager.setSelectedElements(selectedElements)
   end)

   local peek = storeManager.getUtils().peek
   conn2 = store.replacerElementObs:onChange(function()
        if peek(store.replacerElement) > 0 then
            controller.replace()
        end
    end)
end


local replaceElementsBy = function(listElements, replacer, options)

    ChangeHistoryService:SetWaypoint("Replacing Elements")

    -- ✅ Ensure the Bin folder exists
    local binFolder = game.Workspace:FindFirstChild("Bin")
    if not binFolder then
        binFolder = Instance.new("Folder")
        binFolder.Name = "Bin"
        binFolder.Parent = game.Workspace
    end

    local originalData = {}
    local replacerData = {}

    local undoData = {}


    -- ✅ Loop through each element in listElements
    for _, element in ipairs(listElements) do
        if element:IsA("BasePart") then -- Ensure only BaseParts are processed            

            if options.confirm then
                -- here should save the element and its parent in order to in the future if is needed then could restore them
                table.insert(originalData,{
                    element = element,
                    parent = element.Parent,
                    transparency = element.Transparency,
                    cframe = element.CFrame,
                    size = element.Size
                })
            end

            -- make the element transparent if it will be deleted
            if options.delete then
                element.Transparency = 1
            end

            -- ✅ Clone the replacer model
            local newClone = replacer:Clone()
            table.insert(replacerData,newClone)

            -- ✅ Save original element data for undo
            table.insert(undoData, {
                originalElement = element,
                replacement = newClone,
                originalParent = element.Parent,
                originalCFrame = element.CFrame,
                originalSize = element.Size
            })

            -- ✅ Set the cloned object's Parent & Name
            newClone.Parent = element.Parent
            newClone.Name = element.Name

            -- ✅ Ensure the model has a PrimaryPart for positioning
            if newClone:IsA("Model") and newClone.PrimaryPart then
                -- ✅ Apply Position
                newClone:SetPrimaryPartCFrame(element.CFrame)

                -- ✅ Apply Orientation if specified
                if options.orientation then
                    local position = element.Position
                    local orientation = element.Orientation
                    newClone:SetPrimaryPartCFrame(CFrame.new(position) * CFrame.Angles(
                        math.rad(orientation.X),
                        math.rad(orientation.Y),
                        math.rad(orientation.Z)
                    ))
                end

                -- ✅ Apply Scale if specified
                if options.scale then
                    -- ✅ Ensure the replacer has a PrimaryPart
                    if newClone:IsA("Model") and newClone.PrimaryPart then
                        local primaryPart = newClone.PrimaryPart
                        local elementSize = element.Size -- The size to copy from
                        local originalPrimarySize = primaryPart.Size -- The original size of the replacer's PrimaryPart
                
                        -- ✅ Calculate scale factors
                        local scaleX = elementSize.X / originalPrimarySize.X
                        local scaleY = elementSize.Y / originalPrimarySize.Y
                        local scaleZ = elementSize.Z / originalPrimarySize.Z
                
                        -- ✅ Scale the PrimaryPart to match the target element
                        primaryPart.Size = elementSize
                
                        -- ✅ Store original offsets of child parts before scaling
                        local originalOffsets = {}
                
                        for _, part in ipairs(newClone:GetDescendants()) do
                            if part:IsA("BasePart") and part ~= primaryPart then
                                -- Store the original offset relative to the PrimaryPart (Local Space)
                                originalOffsets[part] = primaryPart.CFrame:ToObjectSpace(part.CFrame)
                            end
                        end
                
                        -- ✅ Scale child parts proportionally & reposition them
                        for _, part in ipairs(newClone:GetDescendants()) do
                            if part:IsA("BasePart") and part ~= primaryPart then
                                -- Get original proportions of the child relative to the PrimaryPart
                                local originalSize = part.Size                                
                
                                -- Apply proportional scaling
                                part.Size = Vector3.new(
                                    scaleX * originalSize.X, 
                                    scaleY * originalSize.Y,
                                    scaleZ * originalSize.Z
                                )
                
                                -- ✅ Corrected positioning logic
                                local originalOffset = originalOffsets[part]
                                
                                -- Scale the offset in local space
                                local scaledOffset = CFrame.new(
                                    originalOffset.Position.X * scaleX,
                                    originalOffset.Position.Y * scaleY,
                                    originalOffset.Position.Z * scaleZ
                                )
                
                                -- Maintain the original rotation
                                local newOffset = scaledOffset * originalOffset.Rotation
                                
                                -- ✅ Set the new position relative to the scaled PrimaryPart
                                part.CFrame = primaryPart.CFrame * newOffset
                            end
                        end
                    else
                        warn("⚠️ newClone does not have a valid PrimaryPart for scaling!")
                    end
                end
                
                
            else
                warn("Replacer model does not have a PrimaryPart!")
            end

            -- ✅ Move original element to Bin if `delete` is true
            if options.delete then
                element.Parent = binFolder
            end
        end
    end

    table.insert(undoStack, undoData)

    ChangeHistoryService:SetWaypoint("Elements Replaced")

    return {originalData = originalData, replacerData = replacerData}
end


function controller.replace() 
    local store = storeManager.getStore()
    local peek = storeManager.getUtils().peek
    local elementsToBeReplaced = peek(store.selectedElements)
    local replacerElementId = peek(store.replacerElement)
    local options = {
        delete = peek(store.options.delete), 
        copy = peek(store.options.copy), 
        scale = peek(store.options.scale), 
        confirm = peek(store.options.confirm)
    }

    local model = nil
    local addToWorkspace = false
    if replacerElementId == 1 then
        model = loadEmbeddedModel("appleModel",addToWorkspace)
    elseif replacerElementId == 2 then
        model = loadEmbeddedModel("pearModel",addToWorkspace)
    elseif replacerElementId == 3 then
        model = loadEmbeddedModel("bananaModel",addToWorkspace)
    end

    if model ~= nil then
        local resultData = replaceElementsBy(elementsToBeReplaced, model, options)

        if options.confirm then
            store.showConfirm:set(true)
            store.originalData:set(resultData.originalData)
            store.replacerData:set(resultData.replacerData)
        else
            controller.Confirm()
        end

    else
        print("No asset found!")
    end
end

function controller.Confirm()
    local store = storeManager.getStore()
    store.showComplete:set(true)
    store.showConfirm:set(false)
    store.originalData:set({})
    store.replacerData:set({})
    local binFolder = game.Workspace:FindFirstChild("Bin")
    if binFolder then
        binFolder:Destroy()
    end
end

function controller.Cancel()
    local store = storeManager.getStore()
    local peek = storeManager.getUtils().peek

    for _, elementData in ipairs(peek(store.originalData)) do
        elementData.element.Parent = elementData.parent
        elementData.element.Transparency = elementData.transparency
        elementData.element.CFrame = elementData.cframe
        elementData.element.Size = elementData.size
    end

    local replacerData = peek(store.replacerData)
    for i = #replacerData, 1, -1 do
        local elem = replacerData[i]
        if elem then
            elem:Destroy() -- ✅ Directly destroy
        end
    end

    store.showComplete:set(false)
    store.showConfirm:set(false)
    store.originalData:set({})
    store.replacerData:set({})
end

function controller.Destroy()
    conn1:Disconnect()
    conn2()
end

return controller