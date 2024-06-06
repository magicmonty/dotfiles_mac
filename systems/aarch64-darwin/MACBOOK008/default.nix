{lib, ...}:
with lib;
with lib.mgnix; {
  users.users."martin.gondermann" = {
    name = "martin.gondermann";
    home = "/Users/martin.gondermann";
  };

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
      nonUS.remapTilde = false;
    };
  };

  mgnix = {
    apps = {
      podman = enabled;
    };
    theming.theme = "nightfox";
  };
}
