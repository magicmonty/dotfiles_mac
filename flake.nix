{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin }: {
    darwinConfigurations = {
      "MACBOOK008" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
	modules = [
	  home-manager.darwinModules.home-manager
	  ./hosts/macbook008
	];
      };
    };
  };
}
