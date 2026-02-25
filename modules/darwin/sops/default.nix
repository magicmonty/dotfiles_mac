{config, ...}: {
  sops = let
    martin = config.users.users."martin.gondermannbayoo.net";
  in {
    defaultSopsFile = ../../../secrets/secrets.yaml;

    secrets = {
      "telerik/api-key" = {
        owner = martin.name;
      };
      "telerik/license" = {
        owner = martin.name;
        path = "/Users/martin.gondermannbayoo.net/.telerik/telerik-license.txt";
      };
    };
  };
}
