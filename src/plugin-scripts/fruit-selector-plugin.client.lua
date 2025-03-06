local Plugin = script.Parent
local utils = require(script.Parent.utils["toolbar-button-plugin-creator"])
local app = require(script.Parent["fruit-selector-app"].app)

local pluginTable = utils.setupPluginToolbar(Plugin, "Fruit Selector Toolbar","Fruit Selector", "Selects a Fruit", "")

local pluginButton  = pluginTable[1]

pluginButton.ClickableWhenViewportHidden = true
pluginButton.Click:Connect(app.run)

