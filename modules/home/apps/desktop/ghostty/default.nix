{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.desktop.ghostty.enable = mkOption {
    description = "Whether to enable ghostty terminal";
    type = types.bool;
    default = true;
  };

  config = let
    inherit (config.mgnix.apps.desktop.ghostty) enable;
  in
    mkIf enable {
      xdg.configFile."ghostty/config".text = ''
        theme = nightfox
        font-family = JetBrainsMono Nerd Font
        font-size = 18
        window-decoration = true
        window-padding-y = 8
        window-padding-x = 8
        window-padding-balance = true
        window-padding-color = extend
        window-width = 1000
        window-height = 1000
        mouse-hide-while-typing = true
        shell-integration = zsh
        shell-integration-features = cursor,sudo,title
        background-opacity = 0.8
        background-blur-radius = 20
        clipboard-read = allow
        clipboard-write = allow
        quit-after-last-window-closed = true
        keybind = ctrl+x>c=new_tab
        keybind = ctrl+x>n=next_tab
        keybind = ctrl+x>p=previous_tab
        keybind = ctrl+x>q=quit
        keybind = ctrl+x>r=reload_config
        keybind = ctrl+x>#=new_split:right
        keybind = ctrl+x>-=new_split:down
        keybind = ctrl+x>left=goto_split:left
        keybind = ctrl+h=goto_split:left
        keybind = ctrl+j=goto_split:bottom
        keybind = ctrl+x>down=goto_split:bottom
        keybind = ctrl+k=goto_split:top
        keybind = ctrl+x>up=goto_split:top
        keybind = ctrl+l=goto_split:right
        keybind = ctrl+x>right=goto_split:right
        keybind = ctrl+x>f=toggle_fullscreen
        keybind = ctrl+x>k=toggle_split_zoom
        keybind = ctrl+shift+alt+left=resize_split:left,10
        keybind = ctrl+shift+alt+right=resize_split:right,10
        keybind = ctrl+shift+alt+up=resize_split:up,10
        keybind = ctrl+shift+alt+down=resize_split:down,10
      '';
    };
}
