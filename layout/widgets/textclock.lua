local lain = require("lain")
local wibox = require("wibox")
local markup = lain.util.markup
local theme = require("theme")
local textclock = wibox.widget.textclock(markup("#FFFFFF", "%a %d %b, %H:%M"))

textclock.font = theme.font
theme.cal = lain.widget.cal({
	attach_to = { textclock },
	notification_preset = {
		fg = "#FFFFFF",
		bg = theme.bg_normal,
		position = "top_middle",
		font = "Monospace 10",
	},
})
return textclock
