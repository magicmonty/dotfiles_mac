{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.yazi.enable = mkBoolOption true "Whether to enable yazi";

  config = let
    inherit (config.mgnix.apps.console.yazi) enable;
    aliases = {
      "e." = "yazi .";
      "r" = "yazi";
      ranger = "yazi";
    };
  in
    mkIf enable {
      programs = {
        yazi = {
          enable = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
