local Fusion = require(script.Parent.Parent.packages.Fusion)
local BaseWidget = require(script.Parent.components.BaseWidget)

local scoped = Fusion.scoped
local peek = Fusion.peek

local scope = scoped(Fusion)
local nTimesOpen = Fusion.Value(scope, 0)
local nTimesOpenObs = scope:Observer(nTimesOpen)


local widgetEnabled = false
local widget = nil
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

    local disconnect = nTimesOpenObs:onChange(function()
        print("The new value is: ", peek(nTimesOpen))
        textLabel.Text = "Hello World! " .. peek(nTimesOpen)
    end)

end
function app.run()
    widgetEnabled = not widgetEnabled
    widget.Enabled = widgetEnabled
    if(widgetEnabled) then
        nTimesOpen:set( peek(nTimesOpen) + 1 )
    end
end

return app