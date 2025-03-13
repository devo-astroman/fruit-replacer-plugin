local Plugin = script.Parent
local utils = require(script.Parent.utils["toolbar-button-plugin-creator"])
local app = require(script.Parent["fruit-selector-app"].app)
local constants = require(script.Parent["fruit-selector-app"].constants)

local pluginTable = utils.setupPluginToolbar(Plugin, constants.plugin.toolbarName,constants.plugin.pluginName, constants.plugin.pluginLabel, constants.plugin.iconImage)
local pluginButton  = pluginTable[1]
app.init(plugin,pluginButton)


