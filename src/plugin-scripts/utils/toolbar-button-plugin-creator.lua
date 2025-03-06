local util = {}
function util.setupPluginToolbar(plugin, toolbarName, pluginName, pluginLabel, imageAssetId)    
    
    local toolbar = plugin:CreateToolbar(toolbarName)
    local pluginButton = toolbar:CreateButton(pluginName,pluginLabel,imageAssetId)

    return {pluginButton, toolbar}
end

return util
