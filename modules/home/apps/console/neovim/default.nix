{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.mgnix; {
  options.mgnix.apps.console.neovim = {
    enable = mkOption {
      description = "Whether to enable neovim.";
      type = types.bool;
      default = true;
    };

    package = mkOption {
      type = types.package;
      default = pkgs.neovim-lite.extend {
        config = {
          inherit (osConfig.mgnix.theming) theme;
          plugins = {
            luasnip.fromLua = [
              {paths = ./snippets;}
            ];
          };
        };
      };
      description = "The package to use for neovim.";
    };
  };

  config = let
    inherit (config.mgnix.apps.console.neovim) enable package;
    aliases = {
      v = "nvim";
      vim = "nvim";
      vi = "nvim";
      vimdiff = "nvim -d";
    };
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

      programs = {
        zsh.shellAliases = aliases;
        bash.shellAliases = aliases;
      };
    };
}
