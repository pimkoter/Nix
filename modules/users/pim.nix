{
  flake.nixosModules.pim = {
    users.users.pim = {
      isNormalUser = true;
      #hashedPasswordFile = config.sops.secrets."passwords/pim".path;
      initialPassword = "12345";
      extraGroups = [
        "root"
        "wheel"
      ];
    };
  };
}
