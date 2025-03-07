local Fusion = require(script.Parent.Parent.packages.Fusion)
local BaseWidget = require(script.Parent.components.BaseWidget)

local MainSection = require(script.Parent.sections.MainSection)
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
    widget = BaseWidget.getBaseWidget(plugin,"fruitSelectorGui","Fruit Selector", 600, 400, 200, 100)
    widget.Enabled = widgetEnabled;

    widget:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not widget.Enabled then
            widgetEnabled = false
        end
    end)

    local greetText = GreetText(scope, {
        greetMsg = "Hello there!"
    }) 

    local greetText2 = GreetText(scope, {
        greetMsg = "Hello my World!"
    }) 

    local greetText3 = GreetText(scope, {
        greetMsg = "Very cool!"
    })

    local mainSection = MainSection(scope, { LeftComponent = greetText,  RightComponent = greetText2, BottomComponent = greetText3, Show = true})
    print("mainSection ", mainSection)
    mainSection.Parent = widget



    local disconnect = nTimesOpenObs:onChange(function()
        print("The new value is: ", peek(nTimesOpen))
        --[[ textLabel.Text = "Hello World! " .. peek(nTimesOpen) ]]
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