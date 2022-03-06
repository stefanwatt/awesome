local theme = require("theme")
local lain = require("lain")
local markup = lain.util.markup
local file = io.open("/home/stefan/.config/openweather_api_key.txt", "r")
io.input(file)
local openweather_api_key = io.read()
weather_widget = lain.widget.weather({
	APPID = openweather_api_key,
	city_id = 2643743,
	notification_preset = { font = "Monospace 10" },
	settings = function()
		units = math.floor(weather_now["main"]["temp"])
		widget:set_markup(" " .. markup.font(theme.font, units .. "°C") .. " ")
	end,
})
return weather_widget
