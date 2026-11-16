{ inputs, ... }:
{
  perSystem =
    { system, ... }:
    let
      unFree = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (pkg.pname or "") [
            "spotify"
            "ltspice"
            "android-sdk-platform-tools"
            "steam-unwrapped"
            "cuda_cudart"
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
          config = unFree;
        };
      };
    };
}
