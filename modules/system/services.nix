{
  flake.nixosModules.services = {
    services = {
      avahi = {
        enable = true;
        openFirewall = true;
      };
      printing.enable = true;
      openssh.enable = true;
      upower.enable = true;
      xserver.xkb.layout = "us";
      blueman.enable = true;
      fail2ban = {
        enable = true;
        bantime = "10m";
        bantime-increment.factor = "6";
      };
    };
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };
}
