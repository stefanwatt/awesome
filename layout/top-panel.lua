local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local TaskList = require("widget.task-list")
local TagList = require("widget.tag-list")
local gears = require("gears")
local clickable_container = require("widget.material.clickable-container")
local mat_icon_button = require("widget.material.icon-button")
local mat_icon = require("widget.material.icon")
local dpi = require("beautiful").xresources.apply_dpi
local icons = require("theme.icons")
-- widgets
local textclock = require("layout.widgets.textclock")
local weather_widget = require("layout.widgets.weather")
--streetturtle widgets
local net_speed_widget = require("awesome-wm-widgets.net-speed-widget.net-speed")
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local todo_widget = require("awesome-wm-widgets.todo-widget.todo")
-- Titus - Horizontal Tray
local systray = wibox.widget.systray()
systray:set_horizontal(true)
systray:set_base_size(20)
systray.forced_height = 20
local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(gears.table.join(awful.button({}, 1, nil, function()
	awful.spawn(awful.screen.focused().selected_tag.defaultApp, {
		tag = _G.mouse.screen.selected_tag,
		placement = awful.placement.bottom_right,
	})
end)))

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
	local layoutBox = clickable_container(awful.widget.layoutbox(s))
	layoutBox:buttons(awful.util.table.join(
		awful.button({}, 1, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 3, function()
			awful.layout.inc(-1)
		end),
		awful.button({}, 4, function()
			awful.layout.inc(1)
		end),
		awful.button({}, 5, function()
			awful.layout.inc(-1)
		end)
	))
	return layoutBox
end

local TopPanel = function(s)
	local panel = wibox({
		ontop = true,
		screen = s,
		height = dpi(32),
		width = s.geometry.width,
		x = s.geometry.x,
		y = s.geometry.y,
		stretch = false,
		bg = beautiful.background.hue_800,
		fg = beautiful.fg_normal,
		struts = {
			top = dpi(32),
		},
	})

	panel:struts({
		top = dpi(32),
	})

	panel:setup({
		layout = wibox.layout.align.horizontal,
		expand = "none",
		{
			layout = wibox.layout.fixed.horizontal,
			-- Create a taglist widget
			TagList(s),
			TaskList(s),
			add_button,
		},
		{ -- Middle widgets
			layout = wibox.layout.flex.horizontal,
			max_widget_size = 2500,
			textclock,
		},
		{
			layout = wibox.layout.fixed.horizontal,
			weather_widget,
			cpu_widget({
				width = 70,
				step_width = 2,
				step_spacing = 0,
				color = "#434c5e",
			}),
			ram_widget(),
			net_speed_widget(),
			todo_widget(),
			wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
			-- Layout box
			LayoutBox(s),
		},
	})

	return panel
end

return TopPanel
