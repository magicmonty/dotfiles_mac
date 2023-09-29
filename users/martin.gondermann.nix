{
  stateVersion,
  ...
}: {
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
  };

  sys.software.wezterm.enable = true;
}
