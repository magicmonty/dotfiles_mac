{pkgs, ...}: let
  better-commits = pkgs.callPackage (import ./better-commits.nix) {};
in {
  config = {
    home.packages = [
      pkgs.nodePackages."@angular/cli"
      better-commits
      pkgs.nodejs_20
    ];
  };
}
