{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.eza = moduleWithSystem (
    { self', ... }: {
      programs.eza = {
        enable = true;
        package = self'.packages.eza;
      };
    }
  );
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        eza = inputs.wrappers.wrappers.eza.wrap {
          inherit pkgs;
          package = pkgs.eza;
          addFlag = [
            "--group-directories-first"
            "--no-quotes"
            "--header"
            "--icons=always"
            "--classify"
            "--hyperlink"
          ];
        };
      };
    };
}
