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
    image = ./${theme}.png;
  in {
    system.activationScripts.postActivation.text =
      # bash
      ''
        osascript -e 'set desktopImage to POSIX file "${image}"
        tell application "Finder"
          set desktop picture to desktopImage
        end tell'
      '';
    stylix = {
      enable = true;
      polarity = lib.mkDefault "dark";
      image = lib.mkDefault image;
      base16Scheme = lib.mkDefault ./${theme}.yaml;
      autoEnable = lib.mkDefault false;
      homeManagerIntegration = {
        followSystem = true;
        autoImport = true;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
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

        sizes = {
          terminal = 18;
          popups = 14;
        };
      };
    };
  };
}
