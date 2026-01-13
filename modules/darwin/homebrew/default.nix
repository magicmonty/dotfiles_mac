_: {
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
      "gnu-sed"
      "gnutls"
      "krb5"
      "nvm"
      "scrcpy"
    ];
    casks = [
      "alt-tab"
      "android-platform-tools"
      "azure-data-studio"
      "beyond-compare"
      "bruno"
      "chatgpt"
      "citrix-workspace"
      "drawio"
      "enpass"
      "figma"
      "firefox"
      "freecad"
      "fork" # GIT Client
      "ghostty"
      "gimp"
      "google-chrome"
      "inkscape"
      "jellyfin-media-player"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keepassxc"
      "microsoft-auto-update"
      "microsoft-openjdk@21"
      "microsoft-teams"
      "obsidian"
      "passepartout"
      "raycast"
      "sf-symbols"
      "tailscale-app"
      "visual-studio-code"
    ];
  };
}
