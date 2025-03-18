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
        print("No BaseParts selected. Selection cleared.")
    end
    storeManager.setSelectedElements(selectedElements)
   end)
end

return controller