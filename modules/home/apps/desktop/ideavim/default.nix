{
  lib,
  config,
  ...
}:
with lib; {
  options.mgnix.apps.desktop.ideavim.enable = mkOption {
    description = "Whether to enable ideavim";
    type = types.bool;
    default = true;
  };

  config = mkIf config.mgnix.apps.desktop.ideavim.enable {
    home.file.".ideavimrc".source = ./ideavimrc;
  };
}
