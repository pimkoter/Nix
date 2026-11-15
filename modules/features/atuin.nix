{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.atuin = moduleWithSystem (
    { self', ... }: {
      programs.atuin = {
        enable = true;
        package = self'.packages.atuin;
      };
    }
  );
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        atuin = inputs.wrappers.wrappers.atuin.wrap {
          inherit pkgs;
          package = pkgs.atuin;
          settings = {
            auto_sync = false;
            search_mode = "fuzzy";
            show_preview = true;
            style = "compact";
          };
        };
      };
    };
}
