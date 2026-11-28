{ self, inputs, ... }:
{
  flake.nixosConfigurations.iso = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      ({ modulesPath, ... }: {
        imports = [
          "${modulesPath}/installer/cd-dvd/installation-cd-base.nix"
          self.nixosModules.bash
        ];

        users.users.nixos = {
          isNormalUser = true;
          password = null;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
        };

        systemd.targets = {
          sleep.enable = false;
          suspend.enable = false;
          hibernate.enable = false;
          hybrid-sleep.enable = false;
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];

        nixpkgs = {
          config.allowUnfree = true;
          hostPlatform = "x86_64-linux";
        };
      })
    ];
  };
}
