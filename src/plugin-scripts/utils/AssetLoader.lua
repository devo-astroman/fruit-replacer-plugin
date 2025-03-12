local InsertService = game:GetService("InsertService")

return function (assetId, fn)
    local success, assetModel = pcall(function()
        return InsertService:LoadAsset(assetId)
    end)

    if success and assetModel then
        local object = assetModel:GetChildren()[1] -- Get the first child of the model
        if object then
            fn(object)

            
        else
            warn("No object found inside the asset.")
            
        end
    else
        warn("Failed to load asset. Check if the AssetId is valid and the asset is owned or accessible.")        
    end
end
