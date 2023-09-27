{
  config,
  lib,
  pkgs,
  ...
}:
with lib; 
{
  home = {
    packages = with pkgs; [
      alejandra
      fd
      lua-language-server
      marksman
      nil
      omnisharp-roslyn
      python311
      python311Packages.pip
      ripgrep
      statix
      stylua
      tree-sitter
      unzip
    ];

    sessionVariables = {
      FZF_DEFAULT_COMMAND = "rg --files | sort -u";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    file.".config/nvim" = {
      source = ./config;
      recursive = true;
    };
  };

  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    neovim = {
      enable = true;

      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;

      withNodeJs = true;
      withPython3 = true;
      withRuby = true;

      extraPackages = with pkgs; [
        cargo
        gcc
        nodejs
        ruby
        python310
      ];

      extraLuaConfig = ''
        require("magicmonty")

        local status, ts_install = pcall(require, "nvim-treesitter.install")
        if status then
          ts_install.compilers = { "${pkgs.gcc}/bin/gcc" }
        end
      '';
    };

    zsh.sessionVariables = {
      NVIM_LISTEN_ADDRESS = "~/.cache/nvim/server.pipe";
    };
  };
}
