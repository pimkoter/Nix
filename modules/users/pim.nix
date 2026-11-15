{
  flake.nixosModules.pim = {
    users.users.pim = {
      isNormalUser = true;
      initialPassword = "12345";
      extraGroups = [
        "root"
        "wheel"
      ];
    };
  };
}
