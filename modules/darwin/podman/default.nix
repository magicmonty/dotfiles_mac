{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mgnix.apps.podman.enable = mkOption {
    description = "Whether to enable the podman app";
    default = false;
    type = types.bool;
  };

  config = mkIf config.mgnix.apps.podman.enable {
    environment.systemPackages = with pkgs; [
      podman-compose
    ];
  };
}
