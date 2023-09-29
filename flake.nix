{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    self,
    home-manager,
    darwin,
  }: let
    stateVersion = "23.11";
  in {
    darwinConfigurations = {
      MACBOOK008 = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        specialArgs = {
          inherit stateVersion;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/macbook008.nix
        ];
      };
    };
  };
}
