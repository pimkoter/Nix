{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.herdr = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.herdr ];
    }
  );
  perSystem =
    {
      pkgs,
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
              copy_mode = "prefix+a";

              split_vertical = "prefix+v";
              split_horizontal = "prefix+s";
            };

            ui = {
              mouse_capture = true;
              pane_borders = "auto";
              pane_outer_borders = false;
              pane_gaps = false;
              pane_scrollbars = false;
            };

            theme.name = "terminal";
            session.resume_agents_on_restore = true;
          };
        };
      };
    };
}
