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

    if #selected > 0 then
        selectedElements = selected -- Save selection
        print("Selected Elements:", #selectedElements)
        for _, obj in pairs(selectedElements) do
            print("Selected:", obj.Name)
        end
    else
        -- If no elements are selected, reset the table
        selectedElements = {}
        print("No elements selected. Selection cleared.")
    end
    storeManager.setSelectedElements(selectedElements)
   end)
   
    
end

return controller