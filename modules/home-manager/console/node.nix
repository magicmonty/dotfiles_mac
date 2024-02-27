{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nodePackages."@angular/cli"
      nodejs_20
    ];
  };
}
