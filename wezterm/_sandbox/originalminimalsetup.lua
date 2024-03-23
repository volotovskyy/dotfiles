local wezterm = require("wezterm")
local act = wezterm.action

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-ligature", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.harfbuzz_features then
		-- If we haven't overridden it yet, then override with ligatures disabled
		overrides.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	else
		-- else we did already, and we should disable out override now
		overrides.harfbuzz_features = nil
	end
	window:set_config_overrides(overrides)
end)

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
			action = act.ToggleFullScreen,
		},
		{
			key = "a",
			mods = "CTRL",
			action = act.QuickSelectArgs({
				label = "open url",
				patterns = { "https?://\\S+" },
				action = wezterm.act_callback(function(window, pane)
					local url = window:get_selection_text_for_pane(pane)
					wezterm.open_with(url)
				end),
			}),
		},
		{
			key = "o",
			mods = "CTRL",
			action = act.EmitEvent("toggle-opacity"),
		},
		{
			key = "l",
			mods = "CTRL",
			action = act.EmitEvent("toggle-ligature"),
		},
	},
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = act.OpenLinkAtMouseCursor,
		},
	},
}

-- M.leader = {
-- 	key = "a",
-- 	mods = "CTRL",
-- }
--
-- return M
