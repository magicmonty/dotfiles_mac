{
  description = "My MacOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-25.11-darwin";
    unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:magicmonty/nixvim";
    nix-ai-tools.url = "github:numtide/nix-ai-tools";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:lnl7/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs = {
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs: let
    namespace = "mgnix";
  in
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = ./.;
      package-namespace = namespace;
      channels-config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
        allowListedLicenses = [
          "fsl11Mit"
        ];
      };

      snowfall = {
        inherit namespace;
        meta = {
          name = namespace;
          title = "My MacOS config";
        };
      };

      systems.modules.darwin = with inputs; [
        {
          system.stateVersion = 5;
        }
        stylix.darwinModules.stylix
      ];
    };
}
