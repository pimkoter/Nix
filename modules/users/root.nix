{
  flake.nixosModules.root =
    {
      config,
      ...
    }:
    {
      users = {
        mutableUsers = false;
        users.root = {
          hashedPasswordFile = config.sops.secrets."passwords/root".path;
        };
      };
    };
}
