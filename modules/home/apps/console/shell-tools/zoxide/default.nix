{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.zoxide.enable = mkBoolOption true "Whether to enable zoxide";

  config = let
    inherit (config.mgnix.apps.console.zoxide) enable;
    aliases = {
      zz = "z -"; # Toggle last directory via zoxide
    };
  in
    mkIf enable {
      programs = {
        zoxide = {
          enable = true;
          enableZshIntegration = true;
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
