{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.kitty = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.kitty ];
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

            # Base16 colors
            background = "#${colorPalette.b00}";
            foreground = "#${colorPalette.b05}";
            selection_background = "#${colorPalette.b02}";
            selection_foreground = "#${colorPalette.b05}";
            cursor = "#${colorPalette.b05}";
            cursor_text_color = "#${colorPalette.b00}";

            # Normal ANSI colors
            color0 = "#${colorPalette.b00}";
            color1 = "#${colorPalette.b08}";
            color2 = "#${colorPalette.b0B}";
            color3 = "#${colorPalette.b0A}";
            color4 = "#${colorPalette.b0D}";
            color5 = "#${colorPalette.b0E}";
            color6 = "#${colorPalette.b0C}";
            color7 = "#${colorPalette.b05}";

            # Bright ANSI colors
            color8 = "#${colorPalette.b03}";
            color9 = "#${colorPalette.b08}";
            color10 = "#${colorPalette.b0B}";
            color11 = "#${colorPalette.b0A}";
            color12 = "#${colorPalette.b0D}";
            color13 = "#${colorPalette.b0E}";
            color14 = "#${colorPalette.b0C}";
            color15 = "#${colorPalette.b07}";

            # Tabs
            active_tab_background = "#${colorPalette.b0D}";
            active_tab_foreground = "#${colorPalette.b00}";
            inactive_tab_background = "#${colorPalette.b01}";
            inactive_tab_foreground = "#${colorPalette.b04}";

            # Borders and URLs
            url_color = "#${colorPalette.b0C}";
            active_border_color = "#${colorPalette.b0D}";
            inactive_border_color = "#${colorPalette.b02}";
            bell_border_color = "#${colorPalette.b08}";
          };
        };
      };
    };
}
