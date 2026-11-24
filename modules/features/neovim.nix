{ moduleWithSystem, ... }: {
  flake.nixosModules.neovim = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [
        self'.packages.neovim
      ];
    }
  );

  perSystem = { inputs', ... }: {
    packages = {
      neovim = inputs'.neovim.packages.default;
    };
  };
}
