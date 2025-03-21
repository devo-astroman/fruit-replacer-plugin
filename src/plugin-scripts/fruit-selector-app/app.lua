local Fusion = require(script.Parent.Parent.packages.Fusion)
local OnyxUI = require(script.Parent.Parent.packages.OnyxUI)
local BaseWidget = require(script.Parent.components.BaseWidget)
local PluginTheme = require(script.Parent.PluginTheme)

local Router = require(script.Parent.router)
local Main = require(script.Parent.sections.view.Main)

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
    
    storeManager.init(Fusion,scope)    
    local store = storeManager.getStore()
    controller.init(plugin,storeManager)
    controller.run()

    local Themer = OnyxUI.Themer
	local myTheme = Themer.NewTheme(scope,PluginTheme)

    local mainSection = Themer.Theme:is(myTheme):during(function()
        return Main(scope, {
            StoreRef = store,
            RouterRef = Router,
            ControllerRef = controller
        })
	end)

    local sections = {
        main = mainSection
    }

    Router.create(widget, "main", sections)
    Router.init()

    widget:GetPropertyChangedSignal("Enabled"):Connect(function()
        if not widget.Enabled then
            -- Disconnect any living connections
           app.close()
        else
            controller.run()
        end
    end)
end
function app.run()
    widgetEnabled = not widgetEnabled
    widget.Enabled = widgetEnabled
end

function app.close()
    --clickConnection:Disconnect()
    controller.Destroy()

end

return app