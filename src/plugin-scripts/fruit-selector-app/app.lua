local Fusion = require(script.Parent.Parent.packages.Fusion)
local BaseWidget = require(script.Parent.components.BaseWidget)

local GreetText = require(script.Parent.components.GreetText)

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

    local greetTextBuilder = GreetText.builder(plugin);    
    local greeText = greetTextBuilder(scope, {
        greetMsg = "Hello there!"
    })

    greeText.Parent = widget 


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