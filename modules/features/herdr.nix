{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.herdr = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.herdr ];
    }
  );
  perSystem =
    {
      self',
      pkgs,
      lib,
      ...
    }:
    {
      packages = {
        herdr = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.herdr;
          envDefault = {
            HERDR_CONFIG_PATH = pkgs.writeText "herdr.toml" ''
              onboarding = false

              [terminal]
              default_shell = "${lib.getExe self'.packages.bash}"
              new_cwd = "follow"

              [keys]
              prefix = "ctrl+a"

              # Tabs
              new_tab = "prefix+c"

              # Pane splitting
              split_vertical = "prefix+v"
              split_horizontal = "prefix+s"

              # Pane navigation
              focus_pane_left = ["prefix+m", "alt+m"]
              focus_pane_down = ["prefix+n", "alt+n"]
              focus_pane_up = ["prefix+e", "alt+e"]
              focus_pane_right = ["prefix+i", "alt+i"]

              # Pane management
              zoom = "prefix+z"
              close_pane = "prefix+x"
              copy_mode = "prefix+a"

              # Workspace/session navigation
              workspace_picker = "prefix+f"
              goto = "prefix+w"

              [ui]
              mouse_capture = true

              pane_borders = "auto"
              pane_outer_borders = false
              pane_gaps = false
              pane_scrollbars = false

              hide_tab_bar_when_single_tab = false
              tab_bar_position = "top"

              # Current working directory + 24-hour clock.
              tab_bar_right = [
                { type = "command", command = "printf '%s\n' \"$HERDR_ACTIVE_PANE_CWD\" | ${lib.getExe pkgs.gawk} -F/ '{print $(NF-1) \"/\" $NF}'", interval_seconds = 2, timeout_seconds = 1 },
                { type = "datetime", format = "%H:%M" },
                { type = "zoom" },
              ]
              tab_bar_right_separator = " "

              window_title = "{workspace}: {tab}"

              # Reuse your Stylix palette.
              accent = "#89b4fa"

              [theme]
              name = "terminal"

              [session]
              resume_agents_on_restore = true
            '';
          };
        };
      };
    };
}
