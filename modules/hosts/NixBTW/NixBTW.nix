{ inputs, self, ... }: {
  flake.nixosConfigurations.NixBTW = inputs.nixpkgs.lib.nixosSystem {
    modules = with self.nixosModules; [
      # System configuration
      {
        nixpkgs.hostPlatform = "x86_64-linux";
        networking.hostName = "NixBTW";
      }

      nixSettings
      sysSettings
      sysPkgs
      preservation

      # Boot and storage
      boot
      disko-NixBTW

      # Hardware
      nvidia
      kanata-hrm

      # Networking
      networking

      # Desktop environment
      niri
      noctalia
      ly
      stylix
      kitty

      # System services and security
      pi
      services
      sops
      herdr
      ollama

      # Shell and terminal
      bash
      oh-my-posh

      # CLI utilities
      atuin
      bat
      eza
      fastfetch
      git

      # Applications
      neovim
      spicetify

      # Users
      root
      pim
    ];
  };
}
