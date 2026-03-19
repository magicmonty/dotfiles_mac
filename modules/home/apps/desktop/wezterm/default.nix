{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.desktop.wezterm.enable = mkOption {
    description = "Whether to enable wezterm terminal";
    type = types.bool;
    default = true;
  };

  config = let
    inherit (config.mgnix.apps.desktop.wezterm) enable;
  in
    mkIf enable {
      programs.wezterm = {
        enable = true;
        enableBashIntegration = false;
        enableZshIntegration = true;
        extraConfig =
          # lua
          ''
            local wezterm = require("wezterm")
            local config = wezterm.config_builder()
            local act = wezterm.action

            wezterm.on("gui-startup", function(cmd)
            	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
            	window:gui_window():maximize()
            end)

            config.font_size = 18
            config.font = wezterm.font("JetBrainsMono NF")

            config.audible_bell = "Disabled"
            config.custom_block_glyphs = true
            config.anti_alias_custom_block_glyphs = true
            config.exit_behavior = "Close"
            config.force_reverse_video_cursor = false
            config.hide_mouse_cursor_when_typing = true
            config.default_cursor_style = "SteadyBar"
            config.hide_tab_bar_if_only_one_tab = true
            config.use_fancy_tab_bar = false
            config.prefer_to_spawn_tabs = true
            config.show_new_tab_button_in_tab_bar = false
            config.warn_about_missing_glyphs = false
            config.pane_focus_follows_mouse = false
            config.window_close_confirmation = "NeverPrompt"
            config.window_background_opacity = 0.8
            config.macos_window_background_blur = 20
            config.window_decorations = "RESIZE"

            config.window_frame = {
            	inactive_titlebar_bg = "#192330",
            	active_titlebar_bg = "#192330",
            	inactive_titlebar_border_bottom = "#29394f",
            	active_titlebar_border_bottom = "#29394f",
            	button_fg = "#aeafb0",
            	button_bg = "#192330",
            	button_hover_bg = "#29394f",
            	button_hover_fg = "#cdcecf",
            }
            config.colors = {
            	foreground = "#e4e4e5",
            	background = "#192330",
            	selection_bg = "#29394f",
            	selection_fg = "#aeafb0",
            	cursor_bg = "#aeafb0",
            	cursor_border = "#aeafb0",

            	tab_bar = {
            		background = "#192330",
            		active_tab = {
            			bg_color = "#192330",
            			fg_color = "#cdcecf",
            			intensity = "Bold",
            		},
            		inactive_tab = {
            			bg_color = "#212e3f",
            			fg_color = "#71839b",
            			intensity = "Normal",
            		},
            		inactive_tab_hover = {
            			bg_color = "#192330",
            			fg_color = "#cdcecf",
            			intensity = "Bold",
            			underline = "Single",
            		},
            		new_tab = {
            			bg_color = "#212e3f",
            			fg_color = "#aeafb0",
            			intensity = "Bold",
            		},
            		new_tab_hover = {
            			bg_color = "#192330",
            			fg_color = "#cdcecf",
            			intensity = "Bold",
            			underline = "Single",
            		},
            	},

            	ansi = {
            		"#192330",
            		"#c94f6d",
            		"#81b29a",
            		"#dbc074",
            		"#719cd6",
            		"#9d79d6",
            		"#63cdcf",
            		"#aeafb0",
            	},
            	brights = {
            		"#575860",
            		"#c94f6d",
            		"#81b29a",
            		"#dbc074",
            		"#719cd6",
            		"#9d79d6",
            		"#63cdcf",
            		"#e4e4e5",
            	},
            	compose_cursor = "orange",
            }

            local keys = {}
            local resize_pane = "resize_pane"

            config.leader = { key = "x", mods = "CTRL", timeout_milliseconds = 1000 }
            local function mapl(key, action)
            	table.insert(keys, { key = key, mods = "LEADER", action = action })
            end
            local function mapc(key, action)
            	table.insert(keys, { key = key, mods = "CTRL", action = action })
            end

            -- Splits with <Leader># (Horizontal) or <Leader>- (Vertical)
            mapl("#", act.SplitHorizontal({ domain = "CurrentPaneDomain" }))
            mapl("-", act.SplitVertical({ domain = "CurrentPaneDomain" }))

            --  Move between Splits (either <Ctrl>h/j/k/l or <Leader>h/j/k/l or <Leader>ArrowKey)
            mapl("h", act.ActivatePaneDirection("Left"))
            mapl("LeftArrow", act.ActivatePaneDirection("Left"))
            mapc("h", act.ActivatePaneDirection("Left"))

            mapl("j", act.ActivatePaneDirection("Down"))
            mapl("DownArrow", act.ActivatePaneDirection("Down"))
            mapc("j", act.ActivatePaneDirection("Down"))

            mapl("k", act.ActivatePaneDirection("Up"))
            mapl("UpArrow", act.ActivatePaneDirection("Up"))
            mapc("k", act.ActivatePaneDirection("Up"))

            mapl("l", act.ActivatePaneDirection("Right"))
            mapl("RightArrow", act.ActivatePaneDirection("Right"))
            mapc("l", act.ActivatePaneDirection("Right"))

            -- <Leader>r activates resize mode
            mapl("r", act.ActivateKeyTable({ name = resize_pane, one_shot = false }))

            -- <Leader>g or <Ctrl>g opens a new Tab with lazygit
            mapl("g", act.SpawnCommandInNewTab({ args = { "lazygit" } }))
            mapc("g", act.SpawnCommandInNewTab({ args = { "lazygit" } }))

            -- <Leader>t opens a new tab
            mapl("t", act.SpawnTab("CurrentPaneDomain"))
            mapl("c", act.SpawnTab("CurrentPaneDomain"))
            mapl(",", act.ActivateTabRelative(-1))
            mapl(".", act.ActivateTabRelative(1))

            -- <Leader><CTRL>Space or <Leader>Space activates Copy Mode
            table.insert(keys, { key = "Space", mods = "LEADER|CTRL|SHIFT", action = act.ActivateCopyMode })
            table.insert(keys, { key = "Space", mods = "LEADER", action = act.ActivateCopyMode })

            -- <CTRL+SHIFT>r reloads the configuration
            table.insert(keys, { key = "R", mods = "CTRL|SHIFT", action = act.ReloadConfiguration })

            -- <CTRL+x>x or <CTRL+x><CTRL+x> sends a <CTRL+x>
            table.insert(keys, { key = "x", mods = "LEADER", action = wezterm.action.SendKey({ key = "x", mods = "CTRL" }) })
            table.insert(keys, { key = "x", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "x", mods = "CTRL" }) })

            -- <Leader>u opens URL in Browser ( https://www.google.de )
            mapl(
            	"u",
            	act.QuickSelectArgs({
            		label = "open URL",
            		patterns = { "(?:https?://[a-zA-Z0-9_.~!*'();:@&=+$,/?#\\[%-\\]]+|\\\\[\\S ]+)" },
            		action = wezterm.action_callback(function(window, pane)
            			local url = window:get_selection_text_for_pane(pane)
            			wezterm.log_info("opening URL " .. url)
            			wezterm.open_with(url)
            		end),
            	})
            )

            config.keys = keys

            config.key_tables = {
            	[resize_pane] = {
            		{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
            		{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },

            		{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
            		{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },

            		{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
            		{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },

            		{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },
            		{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },

            		-- Cancel the mode by pressing escape
            		{ key = "Escape", action = "PopKeyTable" },
            	},
            	copy_mode = wezterm.gui.default_key_tables().copy_mode,
            }

            return config
          '';
      };
    };
}
