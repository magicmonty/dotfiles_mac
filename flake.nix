{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-24.11-darwin";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:magicmonty/nixvim";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix/release-24.11";
      inputs = {
        home-manager.follows = "home-manager";
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
        {system.stateVersion = 5;}
        stylix.darwinModules.stylix
      ];
    };
}
