{pkgs, ...}: {
  config = {
    home.packages = [
      pkgs.nodePackages."@angular/cli"
      pkgs.nodejs_20
    ];
  };
}
