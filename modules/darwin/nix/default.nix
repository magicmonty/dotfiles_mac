{pkgs, ...}: {
  ids.gids.nixbld = 30000;
  nix = {
    enable = true;
    package = pkgs.nixVersions.stable;
    settings = {
      cores = 0;
      max-jobs = 10;
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "-d";
    };
    extraOptions = "experimental-features = nix-command flakes";
  };
}
