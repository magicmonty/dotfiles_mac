{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.bat.enable = mkBoolOption true "Whether to enable bat";

  config = let
    inherit (config.mgnix.apps.console.bat) enable;
    aliases = {
      cat = "bat";
    };
  in
    mkIf enable {
      programs = {
        bat = {
          enable = true;
          config = {
            theme = "base16-256";
            "italic-text" = "always";
          };
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
