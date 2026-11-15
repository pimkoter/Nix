{ inputs, ... }:
{
  flake.nixosModules.stylix = { pkgs, lib, ... }: {
    imports = [ inputs.stylix.nixosModules.stylix ];

    stylix = {
      enable = true;
      base16Scheme = lib.mkDefault "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

      opacity.terminal = 0.7;

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono";
        };
        sansSerif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono";
        };
        serif = {
          package = pkgs.nerd-fonts.jetbrains-mono;
          name = "JetBrains Mono";
        };
        sizes = {
          applications = 12;
          terminal = 18;
          desktop = 12;
          popups = 12;
        };
      };
    };
  };
}
