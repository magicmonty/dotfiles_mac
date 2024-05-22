{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    eza
    fd
    gum
    jq
    ripgrep
    unzip
    wget
  ];
}
