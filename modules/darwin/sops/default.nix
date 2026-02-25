{
  pkgs,
  config,
  ...
}: {
  environment.systemPackages = [
    pkgs.sops
  ];
  sops = let
    martin = config.users.users."martin.gondermannbayoo.net";
  in {
    defaultSopsFile = ../../../secrets/secrets.yaml;

    age = {
      sshKeyPaths = [
        "/etc/ssh/ssh_host_ed25519_key"
        "/Users/martin.gondermannbayoo.net/.ssh/id_ed25519"
      ];
    };
    secrets = {
      "telerik/api-key" = {
        mode = "0440";
        owner = martin.name;
      };
      "telerik/license" = {
        mode = "0440";
        owner = martin.name;
      };
    };
  };
}
