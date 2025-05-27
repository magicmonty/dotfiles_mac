default:
  @just --list

pre-rebuild:
  git add *.nix

rebuild: pre-rebuild
  sudo darwin-rebuild switch --impure --flake .

clean:
  nix-collect-garbage -d
  sudo nix-collect-garbage -d

update:
  nix flake update
  git add flake.*
  git commit -m "Update flake"

rebuild-update: update rebuild
