local assetFolder = script.Parent.Parent['fruit-selector-app'].assets

return function (modelName, addToWorkspace)

    if assetFolder then
        local model = assetFolder:FindFirstChild(modelName)
        
        if model and model:IsA("Model") then
            local clonedModel = model:Clone()
            if addToWorkspace then
                clonedModel.Parent = game.Workspace -- Insert the cloned model into the workspace                
            end
            print(modelName .. " model loaded successfully!")
            return clonedModel
        else
            warn("Model not found inside PluginAssets folder. " .. modelName)
        end
    else
        warn("PluginAssets folder not found in plugin directory.")
    end
    return nil
end
