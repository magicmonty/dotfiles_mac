{pkgs, ...}: {
  config = {
    home.packages = with pkgs; [
      nodejs_20
      yarn
    ];
  };
}
