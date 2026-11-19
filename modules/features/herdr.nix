{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.herdr = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.herdr ];
    }
  );
  perSystem =
    {
      pkgs,
      colorPalette,
      ...
    }:
    {
      packages = {
        herdr = inputs.wrappers.wrappers.herdr.wrap {
          inherit pkgs;
          package = pkgs.herdr;
          settings = {
            onboarding = false;
            terminal = {
              new_cwd = "follow";
            };
            keys = {
              prefix = "ctrl+a";
              new_tab = "prefix+c";
              split_vertical = "prefix+v";
              split_horizontal = [
                "prefix+s"
              ];
              focus_pane_left = [
                "prefix+m"
                "alt+m"
              ];
              focus_pane_down = [
                "prefix+n"
                "alt+n"
              ];
              focus_pane_up = [
                "prefix+e"
                "alt+e"
              ];
              focus_pane_right = [
                "prefix+i"
                "alt+i"
              ];
              zoom = "prefix+z";
              close_pane = "prefix+x";
              copy_mode = "prefix+a";
              workspace_picker = "prefix+f";
              goto = "prefix+w";
              indexed = {
                tabs = "alt";
              };
            };
            ui = {
              mouse_capture = false;
              pane_borders = true;
              pane_outer_borders = false;
              pane_gaps = false;
              pane_scrollbars = false;
              hide_tab_bar_when_single_tab = false;
              tab_bar_position = "top";
              tab_bar_right_separator = " ";
              window_title = "{workspace}: {tab}";
            };
            theme = {
              custom = {
                sidebar_bg = "transparent";
                active_row_bg = "${colorPalette.b00}";
                selection_bg = "${colorPalette.b02}";
                panel_bg = "${colorPalette.b00}";

                accent = "${colorPalette.b0E}";
                text = "${colorPalette.b05}";
                subtext0 = "${colorPalette.b04}";

                red = "${colorPalette.b08}";
                green = "${colorPalette.b0B}";
                yellow = "${colorPalette.b0A}";
                blue = "${colorPalette.b0D}";
                teal = "${colorPalette.b0C}";
                peach = "${colorPalette.b09}";
                mauve = "${colorPalette.b0E}";
              };
            };
            session = {
              resume_agents_on_restore = true;
            };
          };
        };
      };
    };
}
