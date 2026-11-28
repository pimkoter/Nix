{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.pi = moduleWithSystem (
    { self', ... }: {

      environment.systemPackages = [
        self'.packages.pi
      ];
    }
  );

  perSystem = { inputs', pkgs, ... }: {
    packages.pi = inputs.wrappers.lib.wrapPackage {
      inherit pkgs;
      package = inputs'.pi.packages.pi.override { nodejs_22 = pkgs.nodejs; };
      env = {
        PI_TELEMETRY = "false";
        PI_CODING_AGENT_DIR = "/home/pim/.pi/pi/agent";
        PI_CODING_AGENT_SESSION_DIR = "/home/pim/.pi/pi/sessions";
      };
    };
  };
}
