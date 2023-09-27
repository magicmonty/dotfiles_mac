{
  pkgs,
  stateVersion,
  ...
}: {
  imports = [../modules/home-manager/console];
  programs = {
    home-manager.enable = true;
  };
  home = {
    inherit stateVersion;
  };
}
