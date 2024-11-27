{
  config,
  lib,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.fzf.enable = mkBoolOption true "Whether to enable fzf";

  config = let
    inherit (config.mgnix.apps.console.fzf) enable;
  in
    mkIf enable {
      home.sessionVariables = {
        FZF_DEFAULT_COMMAND = "rg --files | sort -u";
      };
      programs = {
        fzf = {
          enable = true;
          enableZshIntegration = true;
          defaultOptions = [
            "--height 40%"
            "--layout reverse"
            "--border"
            "--inline-info"
          ];
        };
      };
    };
}
