{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  options.mgnix.apps.desktop.feishin = {
    enable = mkOption {
      description = "Whether to enable the feishin navidrome client";
      type = types.bool;
      default = true;
    };
  };

  config = mkIf config.mgnix.apps.desktop.feishin.enable {
    home.packages = with pkgs; [feishin];
  };
}
