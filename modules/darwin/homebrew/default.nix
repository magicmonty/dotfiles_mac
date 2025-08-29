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
      "chatgpt"
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
      "inkscape"
      "jetbrains-toolbox"
      "karabiner-elements"
      "keepassxc"
      "microsoft-auto-update"
      "microsoft-openjdk@21"
      "microsoft-teams"
      "obsidian"
      "raycast"
      "sf-symbols"
      "tailscale-app"
      "vnc-viewer"
      "visual-studio-code"
    ];
  };
}
