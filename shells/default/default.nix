{
  pkgs,
  mkShell,
  inputs,
  ...
}:
mkShell {
  # Create your shell
  packages = with pkgs; [
    age
    sops
    ssh-to-age
    ssh-to-pgp
  ];

  sopsPGPKeyDirs = [
    "${toString ../..}/secrets/keys/hosts"
    "${toString ../..}/secrets/keys/users"
  ];

  nativeBuildInputs = [
    (pkgs.callPackage inputs.sops-nix {}).sops-import-keys-hook
  ];
}
