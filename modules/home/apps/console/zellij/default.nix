{pkgs, ...}: {
  xdg.configFile = {
    "zellij/layouts/compact.kdl" = {
      enable = true;
      text = ''
        layout {
          pane size=1 borderless=true {
            plugin location="compact-bar"
          }
          pane
        }
      '';
    };
    "zellij/layouts/ide.kdl" = {
      enable = true;
      text = ''
        layout {
          default_tab_template {
            pane size=1 borderless=true {
                plugin location="compact-bar"
            }
            children
          }

          tab name="Editor" split_direction="horizontal" {
            pane
          }

          tab name="AI" {
            pane command="copilot" close_on_exit=true
          }

          tab name="GIT" {
            pane command="lazygit" close_on_exit=true
          }

          tab name="Run" {
            pane split_direction="vertical" {
                pane
                pane
            }
          }
        }
      '';
    };
  };
  programs.zellij = let
    autostart = false;
  in {
    enable = true;
    enableZshIntegration = autostart;
    enableBashIntegration = autostart;
    exitShellOnExit = autostart;
    attachExistingSession = autostart;
    settings = {
      theme = "nightfox";
      default_shell = "${pkgs.zsh}/bin/zsh";
      show_startup_tips = false;
      show_release_notes = false;
      pane_frames = false;
      default_layout = "compact";
      copy_command = "pbcopy";
      copy_on_select = true;
      keybinds = {
        normal._children = [
          {
            bind = {
              _args = ["Alt Shift n"];
              _children = [
                {NewPane = "Down";}
              ];
            };
          }
        ];
      };
    };
  };
}
