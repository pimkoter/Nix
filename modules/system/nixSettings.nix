{ inputs, ... }:
{
  flake.nixosModules.nixSettings = { config, ... }: {
    system.stateVersion = "26.11";
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    _module.args = {
      colorPalette = {
        b00 = config.lib.stylix.colors.base00;
        b01 = config.lib.stylix.colors.base01;
        b02 = config.lib.stylix.colors.base02;
        b03 = config.lib.stylix.colors.base03;
        b04 = config.lib.stylix.colors.base04;
        b05 = config.lib.stylix.colors.base05;
        b06 = config.lib.stylix.colors.base06;
        b07 = config.lib.stylix.colors.base07;
        b08 = config.lib.stylix.colors.base08;
        b09 = config.lib.stylix.colors.base09;
        b0A = config.lib.stylix.colors.base0A;
        b0B = config.lib.stylix.colors.base0B;
        b0C = config.lib.stylix.colors.base0C;
        b0D = config.lib.stylix.colors.base0D;
        b0E = config.lib.stylix.colors.base0E;
        b0F = config.lib.stylix.colors.base0F;
      };
    };
  };

  perSystem =
    {
      system,
      lib,
      ...
    }:
    let
      unFree = {
        allowUnfreePredicate =
          pkg:
          builtins.elem (lib.getName pkg) [
            "spotify"
            "ltspice"
            "android-sdk-platform-tools"
            "steam-unwrapped"
            "cuda_cudart"
            "nvidia-settings"
            "nvidia-x11"
          ];
      };
    in
    {
      _module.args = {
        stablePkgs = import inputs.nixpkgsStable {
          inherit system;
        };

        unfreePkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfreePredicate = unFree.allowUnfreePredicate;
        };

        colorPalette = {
          b00 = "#1e1e2e";
          b01 = "#181825";
          b02 = "#313244";
          b03 = "#45475a";
          b04 = "#585b70";
          b05 = "#cdd6f4";
          b06 = "#f5e0dc";
          b07 = "#b4befe";
          b08 = "#f38ba8";
          b09 = "#fab387";
          b0A = "#f9e2af";
          b0B = "#a6e3a1";
          b0C = "#94e2d5";
          b0D = "#89b4fa";
          b0E = "#cba6f7";
          b0F = "#f2cdcd";
        };
      };
    };
}
