{pkgs, ...}: {
  nix = {
    package = pkgs.nixVersions.stable;
    settings = {
      cores = 0;
      max-jobs = 10;
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      options = "-d";
    };
    extraOptions = "experimental-features = nix-command flakes";
  };

  services.nix-daemon.enable = true;
}
