{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.sys.software.wezterm;
in {
  options.sys.software.wezterm = {
    enable = mkEnableOption "WezTerm";
  };

  config = mkIf cfg.enable {
    home = {
      file = {
        ".config/wezterm/wezterm.lua".source = ./wezterm.lua;
        ".config/wezterm/colors/nightfox.toml".source = ./nightfox.toml;
      };
    };
  };
}
