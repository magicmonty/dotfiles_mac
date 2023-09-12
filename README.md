# Install
- Install nix
- clone into `.dotfiles`:
  ```sh
  git clone https://github.com/magicmonty/dotfiles_mac.git .dotfiles
  ```
- build:
  ```sh
  nix build .#darwinConfigurations.<HOSTNAME>.system --extra-experimental-features "nix-command flakes"
  ```
- some initial settings:
  ```sh
  printf 'run\tprivate/var/run\n' | sudo tee -a /etc/synthetic.conf
  sudo /System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
  ```
- install darwin system:
  ```sh
  ./result/sw/bin/darwin-rebuild switch --flake .
  ```

# Keep up to date / after changes

- Update Flake
  ```sh
  nix flake update
  ```
- Install changes:
  ```sh
  darwin-rebuild switch --flake .
  ```
