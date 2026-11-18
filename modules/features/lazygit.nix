{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.lazygit = moduleWithSystem (
    { self', ... }: {
      environment = {
        systemPackages = [ self'.packages.lazygit ];
      };
    }
  );
  perSystem =
    {
      self',
      pkgs,
      ...
    }:
    {
      packages = {
        lazygit = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.lazygit;
          env = {
            EDITOR = self'.packages.neovim;
          };
        };
      };
    };
}
