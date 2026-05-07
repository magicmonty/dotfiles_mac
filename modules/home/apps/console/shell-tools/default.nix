{pkgs, ...}: {
  home.packages = with pkgs; [
    curl
    fd
    gum
    jq
    ncdu
    ripgrep
    unzip
    wget
    oracle-instantclient
  ];
}
