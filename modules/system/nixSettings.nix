{ inputs, ... }:
{
  flake.nixosModules.nixSettings = {
    system.stateVersion = "26.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  perSystem =
    { system, lib, ... }:
    let
      unFree = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "spotify"
            "ltspice"
            "android-sdk-platform-tools"
            "steam-unwrapped"
            "cuda_cudart"
            "nvidia-settings"
            "nvidia-x11"
          ];
      };
    in
    {
      _module.args = {
        stablePkgs = import inputs.nixpkgsStable {
          inherit system;
        };

        unfreePkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfreePredicate = unFree.allowUnfreePredicate;
        };
      };
    };
}
