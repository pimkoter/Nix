{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.git = moduleWithSystem (
    { self', ... }: {
      programs.git = {
        enable = true;
        package = self'.packages.git;
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
        git = inputs.wrappers.wrappers.git.wrap {
          inherit pkgs;
          package = pkgs.git;
          configFile.content = ''
            [color]
            ui = "auto"

            [init]
            defaultBranch = "master"

            [pull]
            rebase = true

            [user]
            email = "pimkoter69@gmail.com"
            name = "pimkoter"
          '';
        };
      };
    };
}
