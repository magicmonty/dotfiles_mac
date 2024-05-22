{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  options.mgnix.apps.desktop.wezterm = {
    enable = mkOption {
      description = "Whether to enable WezTerm";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.mgnix.apps.desktop.wezterm.enable {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;

      extraConfig = ''
        local wt = require('wezterm')
        local act = wt.action
        local mux = wt.mux

        wt.on('gui-startup', function(cmd)
          local tab, pane, window = mux.spawn_window(cmd or {})
          window:gui_window():maximize()
        end)

        -- Utils
        bg = function(color)
          return { Background = { Color = color } }
        end

        fg = function(color)
          return { Foreground = { Color = color } }
        end

        txt = function(text)
          return { Text = text }
        end

        left_arrow = function()
          return M.txt(nf.pl_right_hard_divider)
        end

        right_arrow = function()
          return M.txt(nf.pl_left_hard_divider)
        end

        -- Tab Bar
          
        local function tab_title(tab_info)
          local title = tab_info.tab_title
          if not title or #title == 0 then
            title = tab_info.active_pane.title

            if title == 'pwsh.exe' then
              title = 'Windows Powershell'
            end
          end

          if not tab_info.is_active and tab_info.tab_index < 9 then
            title = (tab_info.tab_index + 1) .. ': ' .. title
          end

          return title
        end

        wt.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
          local colors = config.resolved_palette.tab_bar
          local tab_colors = tab.is_active and colors.active_tab or colors.inactive_tab

          local background = tab_colors.bg_color
          local foreground = tab_colors.fg_color

          return {
            bg(background),
            fg(foreground),
            txt(tab_title(tab)),
          }
        end)

        -- Mappings
        local resize_pane = 'resize_pane'

        -- Config
        return {
          adjust_window_size_when_changing_font_size = false,
          allow_win32_input_mode = true,
          audible_bell = 'Disabled',
          bold_brightens_ansi_colors = 'BrightAndBold',
          color_scheme = 'nightfox',
          custom_block_glyphs = true,
          default_cwd = '/Users/${config.home.username}/src',
          exit_behavior = 'Close',
          font = wt.font('JetBrainsMono Nerd Font'),
          font_size = 18.0,
          force_reverse_video_cursor = false,
          hide_mouse_cursor_when_typing = true,
          hide_tab_bar_if_only_one_tab = false,
          key_tables = {
            [resize_pane] = {
              { key = 'LeftArrow', action = act.AdjustPaneSize({ 'Left', 1 }) },
              { key = 'h', action = act.AdjustPaneSize({ 'Left', 1 }) },

              { key = 'RightArrow', action = act.AdjustPaneSize({ 'Right', 1 }) },
              { key = 'l', action = act.AdjustPaneSize({ 'Right', 1 }) },

              { key = 'UpArrow', action = act.AdjustPaneSize({ 'Up', 1 }) },
              { key = 'k', action = act.AdjustPaneSize({ 'Up', 1 }) },

              { key = 'DownArrow', action = act.AdjustPaneSize({ 'Down', 1 }) },
              { key = 'j', action = act.AdjustPaneSize({ 'Down', 1 }) },

              -- Cancel the mode by pressing escape
              { key = 'Escape', action = 'PopKeyTable' },
            },
            copy_mode = wt.gui.default_key_tables().copy_mode,
          },
          keys = {
            -- Splits with <Leader># (Horizontal) or <Leader>- (Vertical)
            { key = '#', mods = 'LEADER', action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }) },
            { key = '-', mods = 'LEADER', action = act.SplitVertical({ domain = 'CurrentPaneDomain' }) },

            --  Move between Splits (either <Ctrl>h/j/k/l or <Leader>h/j/k/l or <Leader>ArrowKey)
            { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
            { key = 'LeftArrow', mods = 'LEADER', action = act.ActivatePaneDirection('Left') },
            { key = 'h', mods = 'CTRL', action = act.ActivatePaneDirection('Left') },

            { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
            { key = 'DownArrow', mods = 'LEADER', action = act.ActivatePaneDirection('Down') },
            { key = 'j', mods = 'CTRL', action = act.ActivatePaneDirection('Down') },

            { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
            { key = 'UpArrow', mods = 'LEADER', action = act.ActivatePaneDirection('Up') },
            { key = 'k', mods = 'CTRL', action = act.ActivatePaneDirection('Up') },

            { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
            { key = 'RightArrow', mods = 'LEADER', action = act.ActivatePaneDirection('Right') },
            { key = 'l', mods = 'CTRL', action = act.ActivatePaneDirection('Right') },

            -- <Leader>r activates resize mode
            { key = 'r', mods = 'LEADER', action = act.ActivateKeyTable({ name = resize_pane, one_shot = false }) },
            -- <Leader>g or <Ctrl>g opens a new Tab with lazygit
            { key = 'g', mods = 'LEADER', action = act.SpawnCommandInNewTab({ args = { '${pkgs.lazygit}/bin/lazygit' } }) },
            { key = 'g', mods = 'CTRL', action = act.SpawnCommandInNewTab({ args = { '${pkgs.lazygit}/bin/lazygit' } }) },

            -- <Leader>t opens a new tab
            { key = 't', mods = 'LEADER', action = act.SpawnTab('CurrentPaneDomain') },
            { key = ',', mods = 'LEADER', action = act.ActivateTabRelative(-1) },
            { key = '.', mods = 'LEADER', action = act.ActivateTabRelative(1) },

            -- <Leader><CTRL>Space or <Leader>Space activates Copy Mode
              -- { key = 'Space', mods = 'LEADER|CTRL', action = act.ActivateCopyMode },
            -- { key = 'Space', mods = 'LEADER', action = act.ActivateCopyMode },

            -- <CTRL+SHIFT>r reloads the configuration
            { key = 'r', mods = 'CTRL|SHIFT', action = act.ReloadConfiguration },

            -- <Leader>u opens URL in Browser ( https://www.google.de )
            { 
              key = 'u', 
              mods = 'LEADER', 
              action = act.QuickSelectArgs({
                  label = 'open URL',
                  patterns = { "(?:https?://[a-zA-Z0-9_.~!*'();:@&=+$,/?#\\[%-\\]]+|\\\\[\\S ]+)" },
                  action = wt.action_callback(
                    function(window, pane)
                      local url = window:get_selection_text_for_pane(pane)
                      wt.log_info('opening URL ' .. url)
                      wt.open_with(url)
                    end
                  ),
              })
            },
          },
          leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000 },
          warn_about_missing_glyphs = false,
          window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
          launch_menu = {},
          pane_focus_follows_mouse = false,
          unicode_version = 14,
          -- win32_system_backdrop = 'Acrylic',
          window_background_opacity = 0.95,
          tab_bar_style = {
            new_tab = '<+>',
          },
          window_close_confirmation = 'NeverPrompt',
          window_frame = {
            inactive_titlebar_bg = '#131a24',
            active_titlebar_bg = '#131a24',
            inactive_titlebar_border_bottom = '#131a24',
            active_titlebar_border_bottom = '#212e3f',
            button_fg = '#aeafb0',
            button_bg = '#192330',
            button_hover_bg = '#29394f',
            button_hover_fg = '#cdcecf',
          },
          window_padding = {
            left = 0,
            right = 0,
            top = 0,
            bottom = 0,
          },
          ssh_domains = {},
        }'';

      colorSchemes = {
        nightfox = {
          foreground = "#cdcecf";
          background = "#192330";
          cursor_bg = "#cdcecf";
          cursor_border = "#cdcecf";
          cursor_fg = "#192330";
          compose_cursor = "#f4a261";
          selection_bg = "#2b3b51";
          selection_fg = "#cdcecf";
          scrollbar_thumb = "#71839b";
          split = "#131a24";
          visual_bell = "#cdcecf";
          ansi = ["#393b44" "#c94f6d" "#81b29a" "#dbc074" "#719cd6" "#9d79d6" "#63cdcf" "#dfdfe0"];
          brights = ["#575860" "#d16983" "#8ebaa4" "#e0c989" "#86abdc" "#baa1e2" "#7ad5d6" "#e4e4e5"];

          indexed = {
            "16" = "#d67ad2";
            "17" = "#f4a261";
          };

          tab_bar = {
            background = "#131a24";
            inactive_tab_edge = "#131a24";
            inactive_tab_edge_hover = "#212e3f";

            active_tab = {
              bg_color = "#71839b";
              fg_color = "#192330";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            inactive_tab = {
              bg_color = "#212e3f";
              fg_color = "#aeafb0";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            inactive_tab_hover = {
              bg_color = "#29394f";
              fg_color = "#cdcecf";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            new_tab = {
              bg_color = "#192330";
              fg_color = "#aeafb0";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };

            new_tab_hover = {
              bg_color = "#29394f";
              fg_color = "#cdcecf";
              intensity = "Normal";
              italic = false;
              strikethrough = false;
              underline = "None";
            };
          };
        };
      };
    };
  };
}
