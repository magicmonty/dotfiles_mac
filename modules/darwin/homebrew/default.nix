_: {
  homebrew = let
    aerospace-tap = "nikitabobko/tap";
    sketchybar-tap = "FelixKratz/formulae";
  in {
    enable = true;
    brewPrefix = "/opt/homebrew/bin";
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    taps = [
      aerospace-tap
      sketchybar-tap
    ];
    brews = [
      "azure-cli"
      "gnu-sed"
      "gnutls"
      "krb5"
      "nvm"
      "podman"
      "podman-compose"
      "scrcpy"
      "sketchybar"
    ];
    casks = [
      "alt-tab"
      "android-platform-tools"
      "azure-data-studio"
      "beyond-compare"
      "bruno"
      "citrix-workspace"
      "dotnet-sdk"
      "drawio"
      "enpass"
      "figma"
      "firefox"
      "fork" # GIT Client
      "ghostty"
      "gimp"
      "google-chrome"
      "hiddenbar"
      "inkscape"
      "jetbrains-toolbox"
      "keepassxc"
      "rectangle"
      "microsoft-auto-update" # Needed for auto-Updating Teams and Outlook
      "microsoft-teams"
      "microsoft-outlook"
      "obsidian"
      "microsoft-openjdk@21"
      "postman"
      "raycast"
      "sf-symbols"
      "tailscale"
      "vnc-viewer"
      "virtualbox"
      "visual-studio-code"
      "${aerospace-tap}/aerospace"
    ];
  };
}
