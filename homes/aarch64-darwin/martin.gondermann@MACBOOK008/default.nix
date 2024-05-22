{stateVersion, ...}: {
  imports = [
    ../../../modules/home/console
    ../../../modules/home/desktop/wezterm.nix
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
    sessionPath = [
      "~/.dotnet/tools"
    ];
  };

  sys.software.wezterm.enable = true;
}
