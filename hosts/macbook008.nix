{
  pkgs,
  stateVersion,
  ...
}: {
  users.users."martin.gondermann" = {
    name = "martin.gondermann";
    home = "/Users/martin.gondermann";
  };

  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      cores = 0;
      max-jobs = 10;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "-d";
    };
    extraOptions = "experimental-features = nix-command flakes";
  };

  services.nix-daemon.enable = true;

  # if you use zsh (the default on new macOS installations),
  # you'll need to enable this so nix-darwin creates a zshrc sourcing needed environment changes
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
  };

  environment.pathsToLink = ["/share/zsh"];

  # bash is enabled by default

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono" "Monoid"];})
    ];
  };

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

    defaults = {
      dock = {
        autohide = true;
        mru-spaces = true;
        show-recents = true;
        static-only = false;
        expose-animation-duration = 0.01;
      };
      finder = {
        AppleShowAllExtensions = true;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;
        InitialKeyRepeat = 25;
        KeyRepeat = 4;
      };
    };
  };

  launchd = {
    user.envVariables = {
      ANDROID_SDK = "~/Library/Android/sdk";
    };
  };

  homebrew = {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    brews = [
      "azure-cli"
      "krb5"
      "scrcpy"
    ];
    casks = [
      "activitywatch"
      "alfred"
      "android-platform-tools"
      "azure-data-studio"
      "beyond-compare"
      "dotnet-sdk"
      "enpass"
      "firefox"
      "gimp"
      "google-chrome"
      "inkscape"
      "jetbrains-toolbox"
      "keepassxc"
      "rectangle"
      "microsoft-auto-update" # Needed for auto-Updating Teams and Outlook
      "microsoft-teams"
      "microsoft-outlook"
      "sf-symbols"
      "tailscale"
      "vnc-viewer"
      "tunnelblick"
      "visual-studio-code"
      "wezterm"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit stateVersion;};
    users = {
      "martin.gondermann" = ../users/martin.gondermann.nix;
    };
  };
}
