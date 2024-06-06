{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "wallpapers";
  src = ./.;
  installPhase = ''
    mkdir -p $out
    cp images/* $out
  '';
}
