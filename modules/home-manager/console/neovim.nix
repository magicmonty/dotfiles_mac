{
  config,
  lib,
  inputs,
  pkgs,
  system,
  ...
}:
with lib; let
  cfg = config.sys.software;
in {
  options.sys.software.neovim = {
    enable = mkOption {
      type = types.bool;
      default = true;
    };

    lite = mkOption {
      type = types.bool;
      default = true;
    };
  };

  config = mkIf cfg.neovim.enable {
    home = let
      nixvimPkgs = inputs.nixvim.packages.${system};
      nixVimPackage =
        if cfg.neovim.lite
        then nixvimPkgs.lite
        else nixvimPkgs.default;
    in {
      packages = with pkgs; [
        nixVimPackage
        fd
        gnused
        unzip
      ];

      sessionVariables = {
        FZF_DEFAULT_COMMAND = "rg --files | sort -u";
        EDITOR = "nvim";
        VISUAL = "nvim";
      };
    };

    programs.fzf = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
