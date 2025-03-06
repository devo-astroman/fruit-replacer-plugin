
local BaseWidget = require(script.Parent.components.BaseWidget)
local widgetEnabled = false
local widget = nil
local nTimesOpen = 0
local textLabel = nil

local app = {}
function app.init(plugin, pluginButton)
    pluginButton.ClickableWhenViewportHidden = true
    pluginButton.Click:Connect(app.run)
    widgetEnabled = false
    widget = BaseWidget.getBaseWidget(plugin,"fruitSelectorGui","Fruit Selector", 200, 100, 200, 100)
    widget.Enabled = widgetEnabled;

    widget:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not widget.Enabled then
            widgetEnabled = false
        end
    end)

    textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0, 200, 0, 50)
    textLabel.Position = UDim2.new(0.5, -100, 0.5, -25)
    textLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.Font = Enum.Font.SourceSans
    textLabel.TextSize = 20
    textLabel.Parent = widget

end
function app.run()
    widgetEnabled = not widgetEnabled
    widget.Enabled = widgetEnabled
    if(widgetEnabled) then
        nTimesOpen = nTimesOpen + 1
        textLabel.Text = "Hello World! " .. nTimesOpen
    end
end

return app