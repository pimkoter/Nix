{ inputs, self, ... }: {
  flake.nixosConfigurations.NixBTW = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # Set hostplatform
      { nixpkgs.hostPlatform = "x86_64-linux"; }

      disko-NixBTW
      preservation
      boot
      networking
      sops
      stylix
      ly
      sysPkgs
      nvidia

      # Packages
      niri
      bash
      neovim

      # Users
      pim
    ];
  };
}
