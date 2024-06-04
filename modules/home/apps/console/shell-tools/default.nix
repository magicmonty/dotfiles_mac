{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    fd
    gum
    jq
    ripgrep
    unzip
    wget
  ];
}
