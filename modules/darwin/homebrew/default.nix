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
      "cargo-nextest"
      "coreutils"
      "gnu-sed"
      "gnutls"
      "krb5"
      "nvm"
      "pipx"
      "scrcpy"
      "xcp"
      "xcbeautify"
      "xcode-build-server"
    ];
    casks = [
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
      "keybase"
      "logi-options+"
      "microsoft-auto-update"
      "microsoft-openjdk@21"
      "microsoft-teams"
      "obsidian"
      "passepartout"
      "raycast"
      "sf-symbols"
      "supacode"
      "tailscale-app"
      "visual-studio-code"
      "wezterm"
    ];
  };
}
