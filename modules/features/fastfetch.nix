{ inputs, moduleWithSystem, ... }:
{
  flake.nixosModules.fastfetch = moduleWithSystem (
    { self', ... }:
    {
      environment.systemPackages = [ self'.packages.fastfetch ];
    }
  );

  perSystem =
    { colorPalette, pkgs, ... }:
    {
      packages.fastfetch = inputs.wrappers.wrappers.fastfetch.wrap {
        inherit pkgs;
        package = pkgs.fastfetch;

        settings = {
          display = {
            separator = "  󰑃  ";
            color = {
              keys = "${colorPalette.b0D}";
              title = "${colorPalette.b0E}";
              output = "${colorPalette.b05}";
            };
          };

          logo.padding.top = 2;

          modules = [
            "break"
            {
              key = " DISTRO";
              type = "os";
            }
            {
              key = "│ ├";
              type = "kernel";
            }
            {
              key = "│ ├󱎫";
              type = "uptime";
            }
            {
              key = "│ ├";
              text = "install=$(stat -c %W /nix); now=$(date +%s); echo $(((now-install)/86400)) days";
              type = "command";
            }
            {
              key = "│ └";
              type = "shell";
            }
            {
              key = " DE/WM";
              type = "wm";
            }
            {
              key = "│ ├󰉼";
              type = "wmtheme";
            }
            {
              key = "│ ├󰀻";
              type = "icons";
            }
            {
              key = "│ ├";
              type = "cursor";
            }
            {
              key = "│ ├";
              type = "terminalfont";
            }
            {
              key = "│ └";
              type = "terminal";
            }
            {
              key = "󰌢 SYSTEM";
              type = "host";
            }
            {
              format = "{1}";
              key = "  ├󰻠";
              type = "cpu";
            }
            {
              format = "{2}";
              key = "  ├󰻑";
              type = "gpu";
            }
            {
              key = "  ├󰾆";
              type = "memory";
            }
            {
              key = "  └󰩟";
              showIpv4 = true;
              showIpv6 = false;
              type = "localip";
            }
            "break"
            "break"
            {
              type = "colors";
              block = {
                width = 3;
                height = 1;
              };
            }
          ];

          schema = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
        };
      };
    };
}
