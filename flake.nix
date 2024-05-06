{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-23.11-darwin";
    nixvim.url = "github:magicmonty/nixvim";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    home-manager,
    darwin,
    nixvim,
    nixpkgs,
  } @ inputs: let
    stateVersion = "23.11";
    system = "aarch64-darwin";
  in {
    darwinConfigurations = {
      MACBOOK008 = darwin.lib.darwinSystem {
        inherit system;
        specialArgs = {
          inherit stateVersion system inputs;
        };
        modules = [
          home-manager.darwinModules.home-manager
          ./hosts/macbook008.nix
        ];
      };
    };
  };
}
