local loadEmbeddedModel = require(script.Parent.Parent.utils.EmbeddedAssetLoader)

local storeManager = nil
local plugin = nil
local Selection = game:GetService("Selection")

-- Table to store selected elements
local selectedElements = {}

local controller = {}
function controller.init(pluginRef, storeManagerRef)
   plugin = pluginRef
   storeManager = storeManagerRef

   local myStore = storeManagerRef.getStore()
   local peek = storeManagerRef.getUtils().peek
   myStore.selectedElementsObs:onChange(function()
      print("The new TABLE value is: ", peek(myStore.selectedElements))
      --[[ textLabel.Text = "Hello World! " .. peek(nTimesOpen) ]]
  end)

end
function controller.run()
   print("controller run ", Selection)
   local store = storeManager.getStore()
   Selection.SelectionChanged:Connect(function()
    local selected = Selection:Get() -- Get currently selected objects
    selectedElements = {} -- Reset table

    for _, object in pairs(selected) do
        if object:IsA("BasePart") then 
            table.insert(selectedElements, object)
        end
    end

    if #selectedElements > 0 then
        print("Selected BaseParts:", #selectedElements)
        for _, obj in ipairs(selectedElements) do
            print("__ __ __ Selected:", obj.Name)
        end
    else
        store.replacerElement:set(0)
        print("No BaseParts selected. Selection cleared.")
    end
    storeManager.setSelectedElements(selectedElements)
   end)

   local peek = storeManager.getUtils().peek
   store.replacerElementObs:onChange(function()
        print("Should apply the replacement steps if the replacer is different than 0")
        if peek(store.replacerElement) > 0 then
            controller.replace()
        end
    end)

end

 --[[ 
Can you complete the next function? 
local replaceElementsBy = function(listElements, replacer, options)
   

        This function receives 3 paramanters
            listElements: the list of elements (BasePart elements) to take the position and the Parent from, depending on the options can be taken orientation and scale too and once copied the data from the element should be deleted (changed the parent to a folder named "Bin") or not.

            replacer: it is a model that should be cloned, every clone should be placed in each of the position of each element of the listElements, the Parent should be the same Parent that has the element from the listElement and the Name should be copied too. Other options can be applied too from the options parameter

            options: it is a table of keys and booleans { delete:boolean, orientation:boolean, scale:boolean }
                local deleteElement = options.delete -- if true then the element of the listElements should be moved to a new folder named Bin, if false the element should not be removed
                local copyOrientation = options.copy --  if true the new replacer should take the orientation from the current element of the list, if false should ignore the orientation
                local copyScale = options.scale -- same as copyOrientation but with the scale

        
   
end
 ]]

 local replaceElementsBy = function(listElements, replacer, options)
    -- ✅ Ensure the Bin folder exists
    local binFolder = game.Workspace:FindFirstChild("Bin")
    if not binFolder then
        binFolder = Instance.new("Folder")
        binFolder.Name = "Bin"
        binFolder.Parent = game.Workspace
    end

    -- ✅ Loop through each element in listElements
    for _, element in ipairs(listElements) do
        if element:IsA("BasePart") then -- Ensure only BaseParts are processed

            -- make the element transparent if it will be deleted
            if options.delete then
                element.Transparency = 1
            end

            -- ✅ Clone the replacer model
            local newClone = replacer:Clone()

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
                                local relativeScaleX = originalSize.X / originalPrimarySize.X
                                local relativeScaleY = originalSize.Y / originalPrimarySize.Y
                                local relativeScaleZ = originalSize.Z / originalPrimarySize.Z
                
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
                
                        print("✅ Scaling and positioning applied to PrimaryPart and all children proportionally!")
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
    } 
    print("Fill here with replace code!")

    local model = nil
    local addToWorkspace = true
    if replacerElementId == 1 then
        model = loadEmbeddedModel("appleModel",addToWorkspace)
    elseif replacerElementId == 2 then
        model = loadEmbeddedModel("pearModel",addToWorkspace)
    elseif replacerElementId == 3 then
        model = loadEmbeddedModel("bananaModel",addToWorkspace)
    end

    if model ~= nil then
        print(" model _ ", model)
        --[[ modelLoaded:set(model) ]]
        replaceElementsBy(elementsToBeReplaced, model, options)
    else
        print("No asset found!")
    end


end

return controller