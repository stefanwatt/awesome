local awful = require("awful")
local gears = require("gears")
local icons = require("theme.icons")
local apps = require("configuration.apps")
local lain = require("lain")
local tags = {
	{
		icon = icons.chrome,
		type = "chrome",
		defaultApp = apps.default.browser,
		screen = 1,
	},
	{
		icon = icons.code,
		type = "code",
		defaultApp = apps.default.editor,
		screen = 1,
	},
	{
		icon = icons.social,
		type = "social",
		defaultApp = apps.default.social,
		screen = 1,
	},
	{
		icon = icons.game,
		type = "game",
		defaultApp = apps.default.game,
		screen = 1,
	},
	{
		icon = icons.folder,
		type = "files",
		defaultApp = apps.default.files,
		screen = 1,
	},
	{
		icon = icons.music,
		type = "music",
		defaultApp = apps.default.music,
		screen = 1,
	},
	{
		icon = icons.lab,
		type = "any",
		defaultApp = apps.default.rofi,
		screen = 1,
	},
}
local leaved = require("awesome-leaved")
lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1
awful.layout.layouts = {
	awful.layout.suit.tile,
	-- awful.layout.suit.tile.bottom,
	lain.layout.termfair.center,
	awful.layout.suit.floating,
	leaved.layout.suit.tile.right,
	leaved.layout.suit.tile.top,
	leaved.layout.suit.tile.left,
	leaved.layout.suit.tile.bottom,
}

awful.screen.connect_for_each_screen(function(s)
	l = s.geometry.width > s.geometry.height and awful.layout.suit.tile or awful.layout.suit.tile.bottom
	for i, tag in pairs(tags) do
		awful.tag.add(i, {
			icon = tag.icon,
			icon_only = true,
			layout = l,
			gap_single_client = false,
			gap = 4,
			screen = s,
			defaultApp = tag.defaultApp,
			selected = i == 1,
		})
	end
end)

_G.tag.connect_signal("property::layout", function(t)
	local currentLayout = awful.tag.getproperty(t, "layout")
	if currentLayout == awful.layout.suit.max then
		t.gap = 0
	else
		t.gap = 4
	end
end)
