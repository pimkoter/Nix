{
  flake.nixosModules.ly = {
    services.displayManager.ly = {
      enable = true;
      settings = {
        animation = 1;
        bigclock = true;
        blank_password = false;
        clear_password = true;

        default_rm = true;
        hide_borders = false;
      };
    };
  };
}
