{
  pkgs,
  lib,
  ...
}: {
  stylix = {
    polarity = lib.mkDefault "dark";
    image = lib.mkDefault ./wall.png;
    base16Scheme = lib.mkDefault ./nightfox.yaml;
    autoEnable = lib.mkDefault false;
    homeManagerIntegration = {
      followSystem = true;
      autoImport = false;
    };

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };

      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };

      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}
