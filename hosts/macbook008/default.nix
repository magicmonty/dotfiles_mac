{ pkgs, ... }:
{
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
  programs.zsh.enable = true;
  programs.gnupg.agent.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];

  # bash is enabled by default

  system.defaults = {
    dock = {
      autohide = true;
      mru-spaces = false;
      show-recents = false;
      static-only = true;
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

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
    };
    casks = [
      "alfred"
      "jetbrains-toolbox"
      "iterm2"
      "microsoft-teams"
      "microsoft-outlook"
      "enpass"
      "firefox"
      "google-chrome"
      "sf-symbols"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users."martin.gondermann" = { pkgs, ... } : {
      imports = [ ./modules/console ];
      programs = {
        home-manager.enable = true;
      };
      home = {
        stateVersion = "23.05";
      };
    };
  };
}
