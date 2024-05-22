{
  stateVersion,
  inputs,
  system,
  ...
}: {
  imports = [
    ../../../modules/darwin/homebrew
    ../../../modules/darwin/nix
    ../../../modules/darwin/fonts
    ../../../modules/darwin/environment
    ../../../modules/darwin/cli
    ../../../modules/darwin/podman
    ../../../modules/darwin/system-settings
  ];
  config = {
    users.users."martin.gondermann" = {
      name = "martin.gondermann";
      home = "/Users/martin.gondermann";
    };

    mgnix = {
      apps = {
        podman.enable = true;
      };
    };

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit stateVersion inputs system;};
      users = {
        "martin.gondermann" = ../../../homes/${system}/${"martin.gondermann@MACBOOK008"};
      };
    };
  };
}
