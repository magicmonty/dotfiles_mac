default:
  @just --list

pre-rebuild:
  git add *.nix

rebuild: pre-rebuild
  darwin-rebuild switch --flake .

clean:
  nix-collect-garbage -d
  sudo nix-collect-garbage -d

update:
  nix flake update
  git add .
  git commit -m "Update flake"

rebuild-update: update rebuild
