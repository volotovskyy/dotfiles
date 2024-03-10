local wezterm = require("wezterm")

return {
	color_scheme = "Catppuccin Macchiato",
	enable_tab_bar = false,
	font_size = 24.0,
	-- https://wezfurlong.org/wezterm/config/fonts.html
	-- font = wezterm.font("UbuntuMono Nerd Font"),
	macos_window_background_blur = 30,
	--
	-- window_background_image = "/Users/yu/.config/wezterm/wallpapers/wallpeper-pixel-pink.jpg",
	-- window_background_image_hsb = {
	-- 	brightness = 0.01,
	-- 	hue = 1.0,
	-- 	saturation = 0.5,
	-- },
	window_background_opacity = 1.0,
	-- macos rounded corners
	window_decorations = "RESIZE",

	keys = {
		{
			key = "m",
			mods = "CTRL",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = "a",
			mods = "CTRL",
			action = wezterm.action.QuickSelectArgs({
				label = "open url",
				patterns = { "https?://\\S+" },
				action = wezterm.action_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.open_with(url)
				end),
			}),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
