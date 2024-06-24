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
      "krb5"
      "podman"
      "podman-compose"
      "scrcpy"
    ];
    casks = [
      "alt-tab"
      "android-platform-tools"
      "azure-data-studio"
      "beyond-compare"
      "dotnet-sdk"
      "enpass"
      "firefox"
      "fork" # GIT Client
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
      "postman"
      "raycast"
      "sf-symbols"
      "tailscale"
      "vnc-viewer"
      "tunnelblick"
      "visual-studio-code"
      "wezterm"
    ];
  };
}
