{ inputs, self, ... }: {
  flake.nixosConfigurations.NixBTW = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # Set hostplatform
      { nixpkgs.hostPlatform = "x86_64-linux"; }

      disko-NixBTW
      boot
      networking
      sops
      stylix

      # Packages
      niri
      bash
      neovim

      # Users
      pim
    ];
  };
}
