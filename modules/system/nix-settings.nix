{ inputs, ... }:
{
  perSystem = { system, ... }: {
    _module.args = {
      stablePkgs = import inputs.nixpkgsStable {
        inherit system;
      };
    };
  };
}
