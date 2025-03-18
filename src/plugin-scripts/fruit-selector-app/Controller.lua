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

function controller.replace() 
    --[[ local store = storeManager.getStore()
    local peek = storeManager.getUtils().peek
    local elementsToBeReplaced = peek(store.selectedElements) ]]
    print("Fill here with replace code!")

end

return controller