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

  config = let
    colors = config.lib.stylix.colors.withHashtag;
  in
    mkIf config.mgnix.apps.desktop.wezterm.enable {
      programs.wezterm = with colors; {
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
            color_scheme = 'stylix',
            custom_block_glyphs = true,
            default_cwd = '/Users/${config.home.username}/src',
            exit_behavior = 'Close',
            font = wt.font('${config.stylix.fonts.monospace.name}'),
            font_size = ${toString config.stylix.fonts.sizes.terminal},
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
              { key = 'g', mods = 'CTRL|SHIFT', action = act.SpawnCommandInNewTab({ args = { '${pkgs.lazygit}/bin/lazygit' } }) },

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
            leader = { key = 'y', mods = 'CTRL', timeout_milliseconds = 1000 },
            warn_about_missing_glyphs = false,
            window_decorations = 'INTEGRATED_BUTTONS|RESIZE',
            launch_menu = {},
            pane_focus_follows_mouse = false,
            unicode_version = 14,
            -- win32_system_backdrop = 'Acrylic',
            window_background_opacity = ${builtins.toString config.stylix.opacity.terminal},
            tab_bar_style = {
              new_tab = '<+>',
            },
            window_close_confirmation = 'NeverPrompt',
            window_frame = {
              active_titlebar_bg = '${base00}',
              active_titlebar_fg = '${base05}',
              active_titlebar_border_bottom = '${base00}',
              border_left_color = "${base00}",
              border_right_color = "${base00}",
              border_bottom_color = "${base00}",
              border_top_color = "${base00}",
              button_bg = '${base01}',
              button_fg = '${base05}',
              button_hover_bg = '${base05}',
              button_hover_fg = '${base03}',
              inactive_titlebar_bg = '${base01}',
              inactive_titlebar_fg = '${base05}',
              inactive_titlebar_border_bottom = '${base01}',
            },
            command_palette_bg_color = "${base01}",
            command_palette_fg_color = "${base05}",
            command_palette_font_size = ${builtins.toString config.stylix.fonts.sizes.popups},
            window_padding = {
              left = 0,
              right = 0,
              top = 0,
              bottom = 0,
            },
            ssh_domains = {},
          }'';

        colorSchemes = {
          stylix = {
            foreground = base05;
            background = base00;
            cursor_bg = base05;
            cursor_border = base05;
            cursor_fg = base00;
            compose_cursor = base06;
            selection_bg = base02;
            selection_fg = base05;
            scrollbar_thumb = base01;
            split = base03;
            visual_bell = base09;
            ansi = [base00 base08 base0B base0A base0D base0E base0C base05];
            brights = [base03 base08 base0B base0A base0D base0E base0C base07];

            tab_bar = {
              background = base01;
              inactive_tab_edge = base01;
              inactive_tab_edge_hover = base01;

              active_tab = {
                bg_color = base00;
                fg_color = base05;
                intensity = "Normal";
                italic = false;
                strikethrough = false;
                underline = "None";
              };

              inactive_tab = {
                bg_color = base03;
                fg_color = base05;
                intensity = "Normal";
                italic = false;
                strikethrough = false;
                underline = "None";
              };

              inactive_tab_hover = {
                bg_color = base05;
                fg_color = base00;
                intensity = "Normal";
                italic = false;
                strikethrough = false;
                underline = "None";
              };

              new_tab = {
                bg_color = base03;
                fg_color = base05;
                intensity = "Normal";
                italic = false;
                strikethrough = false;
                underline = "None";
              };

              new_tab_hover = {
                bg_color = base05;
                fg_color = base00;
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
