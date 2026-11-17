{
  flake.nixosModules.sysSettings =
    {
      config,
      ...
    }:
    {
      xdg.portal = {
        wlr.enable = true;
        config.common.default = "*";
      };

      services.usbmuxd.enable = true;

      security = {
        polkit.enable = true;
      };

      services.gnome.gnome-keyring.enable = false;

      users = {
        mutableUsers = false;
        users.root = {
          hashedPasswordFile = config.sops.secrets."passwords/root".path;
        };
      };

      time.timeZone = "Europe/Amsterdam";
      i18n.defaultLocale = "en_US.UTF-8";

      system.stateVersion = "25.11";
    };
}
