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
  };

  config = mkIf cfg.neovim.enable {
    home = {
      packages = with pkgs; [
        inputs.nixvim.packages.${system}.default
        fd
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
