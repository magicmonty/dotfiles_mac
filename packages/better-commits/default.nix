{
  lib,
  fetchFromGitHub,
  buildNpmPackage,
}:
buildNpmPackage rec {
  pname = "better-commits";
  version = "1.14.0";

  src = fetchFromGitHub {
    owner = "Everduin94";
    repo = "better-commits";
    rev = "v${version}";
    hash = "sha256-zhLaqX2qgj+pPOj3nb7nL28wfBSsv1nQFBh7wV9uxcY=";
  };

  npmDepsHash = "sha256-XNg+EPX2QGdavsK9aG5/BIr35oa3ssRAP5wFB3RXJX0=";

  meta = with lib; {
    description = "Better commits";
    homepage = "https://github.com/Everduin94/better-commits";
    license = licenses.mit;
    mainProgram = "better-commits";
  };
}
