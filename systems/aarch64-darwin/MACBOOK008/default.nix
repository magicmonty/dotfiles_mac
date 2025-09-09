{lib, ...}:
with lib;
with lib.mgnix; {
  users.users."martin.gondermannbayoo.net" = {
    name = "martin.gondermannbayoo.net";
    home = "/Users/martin.gondermannbayoo.net";
  };

  system = {
    primaryUser = "martin.gondermannbayoo.net";
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      nonUS.remapTilde = false;
    };
  };

  mgnix = {
    apps = {
      podman = disabled;
      docker = enabled;
    };
    theming.theme = "nightfox";
  };
}
