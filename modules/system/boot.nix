{
  flake.nixosModules.boot =
    {
      pkgs,
      ...
    }:
    {
      systemd.services.NetworkManager-wait-online.enable = false;
      boot = {
        kernelPackages = pkgs.linuxPackages_latest;
        kernel.sysctl = {
          "vm.max_map_count" = 2147483642;
        };
        initrd = {
          kernelModules = [
            "i915"
          ];
        };

        consoleLogLevel = 3;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "loglevel=3"
          "rd.systemd.show_status=false"
          "rd.udev.log_level=3"
          "i915.enable_psr=0"
          "vt.global_cursor_default=0"
          "acpi_osi=Linux"
        ];

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          timeout = null;
        };
      };
    };
}
