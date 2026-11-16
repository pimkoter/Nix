{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
      programs.kitty = {
        enable = true;
        package = self'.packages.kitty;
      };
    }
  );
  perSystem =
    {
      pkgs,
      ...
    }:
    {
      packages = {
        kitty = inputs.wrappers.wrappers.kitty.wrap {
          inherit pkgs;
          package = pkgs.kitty;
          settings = {
            background_opacity = 0.7;
            confirm_os_window_close = 0;
            cursor_trail = 1;
            enable_audio_bell = false;
            enabled_layouts = "splits";

            inactive_tab_font_style = "bold";
            active_tab_font_style = "bold";

            mouse_hide_wait = 5;
            scrollback_lines = 10000;

            tab_bar_edge = "top";
            tab_bar_margin_width = 0;
            tab_bar_style = "hidden";
            tab_fade = 1;

            wheel_scroll_min_lines = 1;
            window_padding_width = 4;
          };
        };
      };
    };
}
