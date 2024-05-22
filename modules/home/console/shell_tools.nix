{pkgs, ...}: {
  home.packages = with pkgs; [
    bat
    curl
    delta
    eza
    fd
    fzf
    git
    gum
    jq
    lazygit
    ranger
    ripgrep
    unzip
    wget
    yarn
  ];

  programs = {
    direnv = {
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };

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

    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };

    bat = {
      enable = true;
      config = {
        theme = "base16-256";
        "italic-text" = "always";
      };
    };

    yazi = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
