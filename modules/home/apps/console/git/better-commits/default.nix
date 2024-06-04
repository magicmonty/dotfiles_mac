{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.git.better-commits.enable = mkBoolOption config.mgnix.apps.console.git.enable "Whether to enable better-commits";

  config = let
    inherit (config.mgnix.apps.console.git.better-commits) enable;
    inherit (config.mgnix.apps.console) git;
    aliases = {
      gbc = "git bc";
      gbb = "better-branch";
    };
  in
    mkIf (git.enable && enable) {
      home.packages = with pkgs; [
        mgnix.better-commits
      ];

      programs.zsh.shellAliases = aliases;
      programs.bash.shellAliases = aliases;
    };
}
