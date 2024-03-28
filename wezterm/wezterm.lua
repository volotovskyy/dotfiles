--- wezterm.lua
--- $ figlet -f small Wezterm
--- __      __      _
--- \ \    / /__ __| |_ ___ _ _ _ __
---  \ \/\/ / -_)_ /  _/ -_) '_| '  \
---   \_/\_/\___/__|\__\___|_| |_|_|_|
---

local wezterm = require("wezterm")
-- local utf8 = require("utf8")
local act = wezterm.action

--- cmd+keys that we want to send to neovim.
-- local special_chars_vim_keys_map = {
-- 	s = utf8.char(0xAA),
-- 	x = utf8.char(0xAB),
-- 	b = utf8.char(0xAC),
-- 	["."] = utf8.char(0xAD),
-- 	o = utf8.char(0xAF),
-- 	-- Add more mappings as needed
-- }
--
-- local function send_key_to_neovim(key)
-- 	-- Implement the logic to send the corresponding special character to Neovim
-- 	-- This function should send the special character corresponding to the given key to Neovim
-- 	-- For example, for 's', it should send 0xAA to Neovim
-- 	local specialChar = special_chars_vim_keys_map[key]
-- 	wezterm.window:perform_action({
-- 		SendChars = specialChar,
-- 	})
-- end
--
-- local function is_vim(pane)
-- 	local is_vim_env = pane:get_user_vars().IS_NVIM == "true"
-- 	if is_vim_env == true then
-- 		return true
-- 	end
-- 	local process_name = string.gsub(pane:get_foreground_process_name(), "(.*[/\\])(.*)", "%2")
-- 	return process_name == "nvim" or process_name == "vim"
-- end
--
-- local function bind_super_key_to_vim(key)
-- 	return {
-- 		key = key,
-- 		mods = "CMD",
-- 		action = wezterm.action_callback(function(win, pane)
-- 			local char = special_chars_vim_keys_map[key]
-- 			if char and is_vim(pane) then
-- 				-- Pass the keys through to Neovim
-- 				send_key_to_neovim(key)
-- 			else
-- 				-- If not a Neovim pane or not a mapped key, pass it normally
-- 				win:perform_action({
-- 					SendKey = {
-- 						key = key,
-- 						mods = "CMD",
-- 					},
-- 				}, pane)
-- 			end
-- 		end),
-- 	}
-- end

local config = {}
-- Use config builder object if possible
if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("toggle-opacity", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.5
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

-- /Users/yu/Downloads/wallpapers/Hollow-Knight.jpg

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

-- config.color_scheme = "Tokyo Night"
-- config.font = wezterm.font_with_fallback({
-- 	{ family = "Iosevka Nerd Font", scale = 1.2, weight = "Medium" },
-- 	{ family = "FantasqueSansM Nerd Font", scale = 1.3 },
-- })

config.color_scheme = "Catppuccin Macchiato"
config.font_size = 24.0
config.window_background_opacity = 0.9
config.window_decorations = "RESIZE"
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

-- Keys
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	-- { key = "s", mods = "CMD", action = bind_super_key_to_vim("s").action },
	-- Send C-a when pressing C-a twice
	{ key = "a", mods = "LEADER|CTRL", action = act.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER", action = act.ActivateCommandPalette },

	-- Pane keybindings
	{ key = "s", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "v", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "q", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
	{ key = "m", mods = "LEADER", action = act.TogglePaneZoomState },
	{ key = "o", mods = "LEADER", action = act.RotatePanes("Clockwise") },
	-- We can make separate keybindings for resizing panes
	-- But Wezterm offers custom "mode" in the name of "KeyTable"
	{
		key = "r",
		mods = "LEADER",
		action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
	},

	-- Tab keybindings
	{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
	{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
	{ key = "n", mods = "LEADER", action = act.ShowTabNavigator },
	{
		key = "e",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Renaming Tab Title...:" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:active_tab():set_title(line)
				end
			end),
		}),
	},
	-- Key table for moving tabs around
	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },
	-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
	{ key = "{", mods = "LEADER|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "}", mods = "LEADER|SHIFT", action = act.MoveTabRelative(1) },

	-- workspace
	{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

	-- {
	-- 	key = "a",
	-- 	mods = "LEADER",
	-- 	action = act.QuickSelectArgs({
	-- 		label = "open url",
	-- 		patterns = { "https?://\\S+" },
	-- 		action = wezterm.action_callback(function(window, pane)
	-- 			local url = window:get_selection_text_for_pane(pane)
	-- 			wezterm.open_with(url)
	-- 		end),
	-- 	}),
	-- },
	{
		key = "o",
		mods = "LEADER",
		action = act.EmitEvent("toggle-opacity"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = act.EmitEvent("toggle-ligature"),
	},
}
-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

config.key_tables = {
	resize_pane = {
		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
	move_tab = {
		{ key = "h", action = act.MoveTabRelative(-1) },
		{ key = "j", action = act.MoveTabRelative(-1) },
		{ key = "k", action = act.MoveTabRelative(1) },
		{ key = "l", action = act.MoveTabRelative(1) },
		{ key = "Escape", action = "PopKeyTable" },
		{ key = "Enter", action = "PopKeyTable" },
	},
}

config.mouse_bindings = {
	-- Shift-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SHIFT",
		action = act.OpenLinkAtMouseCursor,
	},
}
-- Tab bar
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

wezterm.on("update-status", function(window, pane)
	-- Workspace name
	local stat = window:active_workspace()
	local stat_color = "#f7768e"
	-- It's a little silly to have workspace name all the time
	-- Utilize this to display LDR or current key table name
	if window:active_key_table() then
		stat = window:active_key_table()
		stat_color = "#7dcfff"
	end
	if window:leader_is_active() then
		stat = "LDR"
		stat_color = "#bb9af7"
	end

	local basename = function(s)
		-- Nothing a little regex can't fix
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
			-- Wezterm introduced the URL object in 20240127-113634-bbcac864
			cwd = basename(cwd.file_path)
		else
			-- 20230712-072601-f4abf8fd or earlier version
			cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Current command
	local cmd = pane:get_foreground_process_name()
	-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
	cmd = cmd and basename(cmd) or ""

	-- Time
	local time = wezterm.strftime("%H:%M")

	-- Left status (left of the tab line)
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
	}))

	-- Right status
	window:set_right_status(wezterm.format({
		-- Wezterm has a built-in nerd fonts
		-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
	}))
end)

--[[ Appearance setting for when I need to take pretty screenshots
config.enable_tab_bar = false
config.window_padding = {
  left = '0.5cell',
  right = '0.5cell',
  top = '0.5cell',
  bottom = '0cell',

}
--]]

return config
