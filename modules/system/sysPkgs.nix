{
  flake.nixosModules.sysPkgs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Display & Wayland
        xdg-desktop-portal-gnome
        xwayland
        xwayland-satellite

        # Hardware & Audio
        blueman
        pavucontrol
        wdisplays
        playerctl
        brightnessctl

        # Core Utilities
        curl
        git
        polkit
        newt
        pkg-config
      ];
    };
}
