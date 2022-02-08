local gtable = require('gears.table')
local default_theme = require('theme.default-theme')
local dpi = require('beautiful').xresources.apply_dpi
-- PICK THEME HERE
local theme = require('theme.titus-theme')

local final_theme = {}
gtable.crush(final_theme, default_theme.theme)
gtable.crush(final_theme, theme.theme)
default_theme.awesome_overrides(final_theme)
theme.awesome_overrides(final_theme)
final_theme.border_width = dpi(5)
return final_theme
