local Fusion = require(script.Parent.Parent.packages.Fusion)
local BaseWidget = require(script.Parent.components.BaseWidget)

local Router = require(script.Parent.router)

local SelectorFruit = require(script.Parent.sections.SelectorFruit)
local EditorFruit = require(script.Parent.sections.EditorFruit)
local CreatorFruit = require(script.Parent.sections.CreatorFruit)

local scoped = Fusion.scoped
local peek = Fusion.peek

local scope = scoped(Fusion)

local nTimesOpen = Fusion.Value(scope, 0)
local nTimesOpenObs = scope:Observer(nTimesOpen)

local fruitSelected = Fusion.Value(scope, "none")
local fruitSelectedObs = scope:Observer(fruitSelected)


local elementsSelected = Fusion.Value(scope, {})
local elementsSelectedObs = scope:Observer(elementsSelected)


local widgetEnabled = false
local widget = nil

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

    local store = {
        fruitSelected = fruitSelected,
        fruitSelectedObs = fruitSelectedObs,
        elementsSelected = elementsSelected,
        elementsSelectedObs = elementsSelectedObs,
    }
    
    local selectorFruitSection = SelectorFruit(scope, {
        storeRef = store,
        routerRef = Router,
        goToEditor = function()
            Router.goToSection("editor")
        end
    })

    local editorFruitSection = EditorFruit(scope, {
        storeRef = store,
        routerRef = Router,
        goToCreator = function()
            Router.goToSection("creator")
        end,
        goToSelector = function()
            Router.goToSection("selector")
        end
    })

    local creatorFruitSection = CreatorFruit(scope, {
        storeRef = store,
        routerRef = Router,
        goToSelector = function()
            Router.goToSection("selector")
        end,
        goToEditor = function()
            Router.goToSection("editor")
        end,
        goToCreator = function()
            Router.goToSection("creator")
        end
    })

    local sections = {
        selector = selectorFruitSection,
        editor = editorFruitSection,
        creator = creatorFruitSection,
    }

    Router.create(widget, "selector", sections)
    Router.init()

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