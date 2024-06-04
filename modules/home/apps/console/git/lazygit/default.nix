{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.git.lazygit.enable = mkBoolOption config.mgnix.apps.console.git.enable "Whether to enable lazygit";

  config = let
    inherit (config.mgnix.apps.console.git.lazygit) enable;
    inherit (config.mgnix.apps.console) git;
    aliases = {
      lg = "lazygit";
    };
  in
    mkIf (git.enable && enable) {
      home.packages = with pkgs; [
        lazygit
      ];

      programs = {
        lazygit = {
          enable = true;
          settings = {
            gui = {
              showIcons = true;
              showRandomTip = false;
              nerdFontsVersion = "3";
            };
            update = {
              method = "never";
            };
            disableStartupPopups = true;
            notARepository = "quit";
          };
        };

        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
