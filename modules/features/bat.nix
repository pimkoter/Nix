{ inputs, moduleWithSystem, ... }:
{
  flake.nixosModules.bat = moduleWithSystem (
    { self', ... }:
    {
      programs.bat = {
        enable = true;
        package = self'.packages.bat;
      };
    }
  );

  perSystem =
    { pkgs, ... }:
    {
      packages.bat = inputs.wrappers.wrappers.bat.wrap {
        inherit pkgs;
        package = pkgs.bat;

        settings = {
          pager = "less -FR";
          style = "full";
        };
      };
    };
}
