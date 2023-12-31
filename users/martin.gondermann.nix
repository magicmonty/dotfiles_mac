{stateVersion, ...}: {
  imports = [
    ../modules/home-manager/console
    ../modules/home-manager/desktop/wezterm.nix
  ];

  programs = {
    home-manager.enable = true;
  };
  home = {
    inherit stateVersion;
    username = "martin.gondermann";
    homeDirectory = "/Users/martin.gondermann";
    sessionVariables = {
      ANDROID_SDK = "~/Library/Android/sdk";
    };
  };

  sys.software.wezterm.enable = true;
}
