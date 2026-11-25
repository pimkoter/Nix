{ moduleWithSystem, ... }:
{
  flake.nixosModules.pim = moduleWithSystem (
    {
      inputs',
      self',
      pkgs,
      unfreePkgs,
      ...
    }:
    {
      config,
      ...
    }:
    {
      users.users.pim = {
        isNormalUser = true;
        hashedPasswordFile = config.sops.secrets."passwords/pim".path;
        shell = self'.packages.bash;
        extraGroups = [
          "root"
          "wheel"
        ];
      };

      environment.systemPackages =
        with pkgs;
        [
          # Browsers / Desktop applications
          blender
          evince
          inputs'.helium.packages.default
          kicad
          libreoffice
          orca-slicer
          poppler-utils
          qbittorrent
          thunderbird

          # CLI utilities
          bottom
          fd
          ffmpeg
          fzf
          jq
          ripgrep
          sops
          tesseract
          unzip
          wl-clipboard-rs

          # Communication
          vesktop

          # Development
          better-adb-sync
          compose2nix
          devenv
          just
          sdkmanager
          verible

          # Gaming
          heroic
          prismlauncher
          satisfactorymodmanager

          # Networking
          dig
          nmap
          wifi-qr
        ]
        ++ [
          unfreePkgs.ltspice
          unfreePkgs.steam-run
          unfreePkgs.android-tools
          self'.packages.git
          self'.packages.freecad
        ];
    }
  );
}
