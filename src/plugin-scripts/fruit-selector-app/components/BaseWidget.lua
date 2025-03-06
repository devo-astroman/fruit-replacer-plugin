local BaseWidget = {}
function BaseWidget.getBaseWidget(plugin, pluginGuiId, title, floatXSize,    floatYSize,    minWidth,    minHeight)

    local widgetInfo = DockWidgetPluginGuiInfo.new(
        Enum.InitialDockState.Float,
        true,
        false,
        floatXSize, 
        floatYSize,  
        minWidth,   
        minHeight    
    )

    local widget = plugin:CreateDockWidgetPluginGui(pluginGuiId, widgetInfo)
    widget.Title = title

    return widget
end

return BaseWidget