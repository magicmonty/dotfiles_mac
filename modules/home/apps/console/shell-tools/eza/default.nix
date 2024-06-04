{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.eza.enable = mkBoolOption true "Whether to enable eza";

  config = let
    inherit (config.mgnix.apps.console.eza) enable;
    aliases = {
      l = "eza --git --icons -lha --color-scale";
    };
  in
    mkIf enable {
      programs = {
        eza = {
          enable = true;
          git = true;
          icons = true;
          enableZshIntegration = true;
          enableBashIntegration = true;
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
