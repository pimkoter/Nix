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
          freecad
          inputs'.helium.packages.default
          kicad
          orca-slicer
          poppler-utils
          qbittorrent
          thunderbird

          # CLI utilities
          bat
          bottom
          fd
          ffmpeg
          fzf
          git
          jq
          lazygit
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
          just
          rustc
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
        ];
    }
  );
}
