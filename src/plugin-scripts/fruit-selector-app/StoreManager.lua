local Fusion = nil
local peek = nil
local store = {
    nSelectedElements = nil,
    selectedElements = nil,
    selectedElementsObs = nil,
    options = nil,
    replacerElement = nil,
    replacerElementObs = nil
}

local storeManager = {}
function storeManager.init(Fusion, scope)
    Fusion = Fusion
    peek = Fusion.peek
    store.nSelectedElements = Fusion.Value(scope, 0)
    store.selectedElements = Fusion.Value(scope, {})
    store.selectedElementsObs = scope:Observer(store.selectedElements)
    store.options = {
        delete = Fusion.Value(scope, false),
        orientation = Fusion.Value(scope, true),
        scale = Fusion.Value(scope, false),
        confirm = Fusion.Value(scope, true),
    }
    store.replacerElement = Fusion.Value(scope, 0)
    store.replacerElementObs = scope:Observer(store.replacerElement)
    
--[[ -- Monitor selected elements
    store.selectedElementsObs:onChange(function()
        print("store.selectedElements >> : ", peek(store.selectedElements))
        for _, obj in pairs(peek(store.selectedElements)) do
            print("HERE:", obj)
        end
    end) ]]

end
function storeManager.setSelectedElements(selectedElements)
    store.nSelectedElements:set(#selectedElements)
    store.selectedElements:set(selectedElements)
end

function storeManager.getStore()
    return store
end

function storeManager.getUtils()
    return {Fusion=Fusion,peek=peek}
end

return storeManager