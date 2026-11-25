{ inputs, moduleWithSystem, ... }:
{
  flake.nixosModules.kanshi = moduleWithSystem (
    { self', ... }: {
      services.kanshi = {
        enable = true;
        package = self'.packages.kanshi;
      };
    }
  );

  perSystem = { pkgs, ... }: {
    packages = {
      kanshi = inputs.wrappers.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.kanshi;
        flags = {
          "-c" = pkgs.writeText "config" ''
            profile laptop {
                 output eDP-1 mode 2560x1600@60Hz scale 1.5 enable position 0,0
             }

             profile workstation {
                 # Main monitor
                 output DP-5 mode 1920x1080@143.994Hz scale 1.0 enable position 0,0

                 # Side monitor
                 output DP-4 mode 1920x1080@60Hz scale 1.0 enable position 1920,0

                 # Laptop centered underneath main monitor
                 output eDP-1 mode 2560x1600@60Hz scale 1.5 enable position 107,1080
             }
          '';
        };
      };
    };
  };
}
