{
  config,
  lib,
  ...
}:
with lib; {
  options.mgnix.apps.podman.enable = mkOption {
    description = "Whether to enable the podman app";
    default = false;
    type = types.bool;
  };

  config = mkIf config.mgnix.apps.podman.enable {
    homebrew.brews = [
      "podman"
      "podman-compose"
    ];
    homebrew.casks = [
      "podman-desktop"
    ];
  };
}
