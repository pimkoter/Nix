{ moduleWithSystem, ... }:
{
  flake.nixosModules.root = moduleWithSystem (
    {
      config,
      ...
    }:
    {
      users.users = {
        mutableUsers = false;
        root = {
          hashedPasswordFile = config.sops.secrets."passwords/root".path;
        };
      };
    }
  );
}
