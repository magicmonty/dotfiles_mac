_: {
  homebrew = let
    aerospace-tap = "nikitabobko/tap";
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
      "obsidian"
      "microsoft-openjdk@21"
      "raycast"
      "sf-symbols"
      "tailscale-app"
      "vnc-viewer"
      "visual-studio-code"
      "${aerospace-tap}/aerospace"
    ];
  };
}
