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
    local frame = Instance.new("Frame")
    frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
    frame.Size = UDim2.new(1, 0, 1, 0) -- Make frame fill widget
    frame.Parent = widget

    return widget
end

return BaseWidget