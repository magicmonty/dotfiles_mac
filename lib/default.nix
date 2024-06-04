{lib, ...}:
with lib; {
  enabled = {enable = true;};
  disabled = {enable = false;};

  mkBoolOption = default: description:
    mkOption {
      inherit default description;
      type = types.bool;
    };
}
