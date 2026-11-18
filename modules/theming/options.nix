{ lib, ... }:
{
  perSystem = {
    options = {
      theme = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "catppuccin";
          description = "The global color theme.";
        };

        flavor = lib.mkOption {
          type = lib.types.str;
          default = "mocha";
          description = "The theme flavor.";
        };
      };
    };
  };
}
