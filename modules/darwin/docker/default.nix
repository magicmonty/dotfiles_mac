{
  config,
  lib,
  ...
}:
with lib; {
  options.mgnix.apps.docker.enable = mkOption {
    description = "Whether to enable docker";
    default = false;
    type = types.bool;
  };

  config = mkIf config.mgnix.apps.docker.enable {
    homebrew.casks = [
      "docker-desktop"
    ];
  };
}
