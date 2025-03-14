local Fusion = nil
local peek = nil
local store = {
    nSelectedElements = nil,
    selectedElements = nil,
    selectedElementsObs = nil,
}

local storeManager = {}
function storeManager.init(Fusion, scope)
    Fusion = Fusion
    peek = Fusion.peek
    store.nSelectedElements = Fusion.Value(scope, 0)
    store.selectedElements = Fusion.Value(scope, {})
    store.selectedElementsObs = scope:Observer(store.selectedElements)
end
function storeManager.setSelectedElements(selectedElements)
    store.nSelectedElements:set(#selectedElements)
    store.selectedElements:set(selectedElements)
end

function storeManager.getStore()
    return store
end

function storeManager.getUtils()
    print("flag ",Fusion, peek)
    return {Fusion=Fusion,peek=peek}
end

return storeManager