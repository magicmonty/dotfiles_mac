{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.mgnix.theming = {
    theme = mkOption {
      description = "The theme to use. (one of nightfox, dayfox, duskfox, dawnfox)";
      type = types.enum ["nightfox" "dayfox" "duskfox" "dawnfox"];
      default = "nightfox";
    };
  };

  config = let
    inherit (config.mgnix.theming) theme;
  in {
    system.activationScripts.postActivation.text =
      # bash
      ''
        osascript -e 'set desktopImage to POSIX file "${pkgs.mgnix.wallpapers}/${theme}.png"
        tell application "Finder"
          set desktop picture to desktopImage
        end tell'
      '';

    stylix = {
      polarity = lib.mkDefault "dark";
      image = lib.mkDefault ./wall.png;
      base16Scheme = lib.mkDefault ./${theme}.yaml;
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
  };
}
