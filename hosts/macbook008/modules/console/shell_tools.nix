{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    eza
    ripgrep
    jq
    fd
    curl
    wget
    bat
    fzf
    gum
    unzip
    git
    lazygit
    delta
    ranger
  ];

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
  };
}
