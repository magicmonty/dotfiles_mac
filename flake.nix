{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-25.05-darwin";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:magicmonty/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.05";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      package-namespace = "mgnix";

      snowfall = {
        namespace = "mgnix";
        meta = {
          name = "mgnix";
          title = "My MacOS config";
        };
      };

      channels-config = {
        allowUnfree = true;
      };

      systems.modules.darwin = with inputs; [
        {
          system.stateVersion = 5;
        }
        stylix.darwinModules.stylix
      ];
    };
}
