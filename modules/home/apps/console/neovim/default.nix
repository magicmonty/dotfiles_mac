{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options.mgnix.apps.console.neovim = {
    enable = mkOption {
      description = "Whether to enable neovim.";
      type = types.bool;
      default = true;
    };

    package = mkOption {
      type = types.package;
      default = pkgs.neovim-lite;
      description = "The package to use for neovim.";
    };
  };

  config = let
    inherit (config.mgnix.apps.console.neovim) enable package;
  in
    mkIf enable {
      home = {
        packages = [
          package
        ];

        sessionVariables = {
          EDITOR = "nvim";
          VISUAL = "nvim";
        };
      };
    };
}
