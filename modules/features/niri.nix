{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.niri = moduleWithSystem (
    { self', ... }: {
      programs.niri = {
        enable = true;
        package = self'.packages.niri;
      };
    }
  );
  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages = {
        niri = inputs.wrappers.wrappers.niri.wrap {
          inherit pkgs;
          package = pkgs.niri;
          settings = {
            spawn-at-startup = [
              "${lib.getExe self'.packages.noctalia}"
              "${lib.getExe self'.packages.noctalia} msg wallpaper-random"
              "${lib.getExe self'.packages.spicetify}"
            ];

            # KEYBINDS
            binds = {
              "Mod+Slash".show-hotkey-overlay = _: { };

              # APPLICATIONS
              "Mod+Space" = _: {
                props.cooldown-ms = 200;
                content.spawn-sh = "${lib.getExe self'.packages.noctalia} msg panel-toggle launcher";
              };

              "Mod+Y" = _: {
                props.cooldown-ms = 200;
                content.spawn-sh = "${self'.packages.noctalia-bookmarks}";
              };

              "Mod+R" = _: {
                props.cooldown-ms = 200;
                content.spawn-sh = "${self'.packages.noctalia-repos}";
              };

              "Mod+W" = _: {
                props.cooldown-ms = 200;
                content.spawn-sh = "${lib.getExe self'.packages.noctalia} msg panel-toggle wallpaper";
              };

              "Mod+P" = _: {
                props.cooldown-ms = 200;
                content.spawn-sh = "${self'.packages.noctalia-clipboard}";
              };

              "Mod+T" = _: {
                props.cooldown-ms = 200;
                content.spawn = [ "${lib.getExe self'.packages.kitty}" ];
              };

              "Mod+B" = _: {
                props.cooldown-ms = 200;
                content.spawn = [ "librewolf" ];
              };

              "Mod+V" = _: {
                props.cooldown-ms = 200;
                content.spawn = [ "${lib.getExe pkgs.pavucontrol}" ];
              };

              # WINDOW BASICS
              "Ctrl+Alt+Shift+Q" = _: {
                props.repeat = false;
                content.close-window = _: { };
              };

              "Ctrl+Alt+Shift+O" = _: {
                props.repeat = false;
                content.toggle-overview = _: { };
              };

              # FOCUS
              "Ctrl+Alt+Shift+M".focus-column-left = _: { };
              "Ctrl+Alt+Shift+I".focus-column-right = _: { };
              "Ctrl+Alt+Shift+N".focus-workspace-down = _: { };
              "Ctrl+Alt+Shift+E".focus-workspace-up = _: { };

              # MOVE
              "Mod+Ctrl+Alt+Shift+M".move-column-left-or-to-monitor-left = _: { };
              "Mod+Ctrl+Alt+Shift+I".move-column-right-or-to-monitor-right = _: { };

              "Mod+Ctrl+Alt+Shift+E".move-column-to-monitor-up = _: { };
              "Mod+Ctrl+Alt+Shift+N".move-column-to-monitor-down = _: { };

              # MONITOR FOCUS
              "Mod+M".focus-monitor-left = _: { };
              "Mod+I".focus-monitor-right = _: { };
              "Mod+E".focus-monitor-up = _: { };
              "Mod+N".focus-monitor-down = _: { };

              # RELATIVE WORKSPACE MOVEMENT
              "Mod+Ctrl+Alt+Shift+U".move-column-to-workspace-down = _: { };
              "Mod+Ctrl+Alt+Shift+O".move-column-to-workspace-up = _: { };

              # COLUMN LAYOUT
              "Ctrl+Alt+Shift+P".switch-preset-column-width = _: { };
              "Ctrl+Alt+Shift+F".maximize-column = _: { };
              "Mod+Ctrl+Alt+Shift+F".fullscreen-window = _: { };
              "Ctrl+Alt+Shift+C".center-column = _: { };
              "Mod+Ctrl+Alt+Shift+C".center-visible-columns = _: { };

              # SCREENSHOTS
              "Mod+S".screenshot = _: { };
            };

            # HOTKEY OVERLAY
            hotkey-overlay.skip-at-startup = _: { };

            # ENVIRONMENT
            environment = {
              QT_QPA_PLATFORM = "wayland";
              ELECTRON_OZONE_PLATFORM_HINT = "auto";
              QT_QPA_PLATFORMTHEME = "kvantum";
              QT_STYLE_OVERRIDE = "kvantum";
              TERMINAL = "kitty";
              XCURSOR_THEME = "Bibata-Modern-Ice";
              XCURSOR_SIZE = "24";
            };

            # GESTURES
            gestures.hot-corners.off = _: { };

            # INPUT
            input = {
              keyboard = {
                xkb = _: { };
                numlock = _: { };
              };

              touchpad = {
                tap = _: { };
                natural-scroll = _: { };
              };

              mouse = _: { };
              trackpoint = _: { };

              focus-follows-mouse = _: {
                props.max-scroll-amount = "0%";
              };
            };

            # LAYOUT
            layout = {
              gaps = 8;

              center-focused-column = "on-overflow";

              always-center-single-column = _: { };

              preset-column-widths = [
                {
                  proportion = 0.33333;
                }
                {
                  proportion = 0.5;
                }
                {
                  proportion = 1.0;
                }
              ];

              default-column-width = {
                proportion = 0.5;
              };

              focus-ring.off = _: { };

              border.width = 2;

              struts = _: { };
            };

            # WINDOW RULES
            prefer-no-csd = true;

            window-rules = [
              {
                matches = [
                  {
                    app-id = "Minecraft";
                  }
                ];

                open-fullscreen = true;
              }
            ];
          };
        };
      };
    };
}
