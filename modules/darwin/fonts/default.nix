{pkgs, ...}: {
  fonts = {
    packages = with pkgs.nerd-fonts; [
      jetbrains-mono
      monoid
      hack
    ];
  };
}
