local Fusion = require(script.Parent.Parent.packages.Fusion)
local BaseWidget = require(script.Parent.components.BaseWidget)

local Router = require(script.Parent.router)
local Main = require(script.Parent.sections.main.Main)

local constants =  require(script.Parent.constants)

local scoped = Fusion.scoped

local scope = scoped(Fusion)

local storeManager = require(script.Parent.StoreManager)
local controller = require(script.Parent.Controller)

local widgetEnabled = false
local widget = nil

local app = {}
function app.init(plugin, pluginButton)
    pluginButton.ClickableWhenViewportHidden = true
    pluginButton.Click:Connect(app.run)
    widgetEnabled = false
    widget = BaseWidget.getBaseWidget(plugin,
    constants.widget.pluginGuiId,
    constants.widget.title,
    constants.widget.floatXSize,
    constants.widget.floatYSize,
    constants.widget.minWidth,
    constants.widget.minHeight)

    widget.Enabled = widgetEnabled;

    widget:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not widget.Enabled then
            widgetEnabled = false
        end
    end)
    storeManager.init(Fusion,scope)    
    local store = storeManager.getStore()
    controller.init(plugin,storeManager)
    controller.run()

    local mainSection = Main(scope, {
        StoreRef = store,
        RouterRef = Router,
    })

    local sections = {
        main = mainSection
    }

    Router.create(widget, "main", sections)
    Router.init()
end
function app.run()
    widgetEnabled = not widgetEnabled
    widget.Enabled = widgetEnabled
end

return app