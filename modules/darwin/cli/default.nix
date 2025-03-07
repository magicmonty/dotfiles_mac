{pkgs, ...}: {
  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
  };

  environment.systemPackages = with pkgs; [
    btop
    fd
    figlet
    gnused
    imagemagick
    markdownlint-cli2
    mermaid-cli
    p7zip
    unzip
  ];
}
