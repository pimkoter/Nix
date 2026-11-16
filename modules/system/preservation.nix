{ inputs, ... }:
{
  flake.nixosModules.preservation = {
    imports = [ inputs.preservation.nixosModules.default ];

    systemd.suppressedSystemUnits = [
      "systemd-machine-id-commit.service"
    ];

    preservation = {
      enable = true;
      preserveAt."/preserve" = {
        files = [
          {
            file = "/etc/machine-id";
            inInitrd = true;
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key";
            mode = "0600";
            inInitrd = true;
          }
          {
            file = "/etc/ssh/ssh_host_ed25519_key.pub";
            mode = "0644";
            inInitrd = true;
          }
        ];

        directories = [
          {
            directory = "/var/lib/nixos";
            inInitrd = true;
          }
          "/var/lib/systemd/timers"
          "/var/lib/bluetooth"
          "/var/log"
          "/etc/NetworkManager/system-connections"
        ];
        users = {
          pim = {
            directories = [
              "Downloads"
              "Pictures"
              "Backups"
              "Notes"
              "Projects"
              "Repos"
              "Games"
              "Virtualmachines"
              ".thunderbird"
              ".steam"
              ".config/spotify"
              ".config/heroic"
              ".config/sops"
              ".config/gh"
              ".config/OrcaSlicer"
              ".local/share/atuin"
              ".local/share/zoxide"
              ".local/share/PrismLauncher"
              ".local/share/Steam"
              ".local/share/kicad"
            ];
            files = [
              ".ssh/known_hosts"
              ".ssh/authorized_keys"
            ];
          };
        };
      };
    };
  };
}
