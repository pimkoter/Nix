{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.oh-my-posh = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.oh-my-posh ];
    }
  );

  perSystem =
    {
      pkgs,
      colorPalette,
      ...
    }:
    {
      packages.oh-my-posh = inputs.wrappers.wrappers.oh-my-posh.wrap {
        inherit pkgs;
        package = pkgs.oh-my-posh;

        configFile = pkgs.writeText "config.json" ''
          {
            "$schema": "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/schema.json",
            "version": 3,

            "palette": {
               "background": "#${colorPalette.b00}",
               "base": "#${colorPalette.b00}",

               "blue": "#${colorPalette.b0D}",
               "comment": "#${colorPalette.b03}",
               "crust": "#${colorPalette.b00}",
               "current_line": "#${colorPalette.b02}",

               "cyan": "#${colorPalette.b0C}",
               "red": "#${colorPalette.b08}",

               "foreground": "#${colorPalette.b05}",
               "green": "#${colorPalette.b0B}",
               "grey": "#${colorPalette.b04}",

               "mantle": "#${colorPalette.b01}",
               "purple": "#${colorPalette.b0E}",

               "none": "#${colorPalette.b05}",
               "orange": "#${colorPalette.b09}",

               "overlay0": "#${colorPalette.b03}",
               "overlay1": "#${colorPalette.b04}",
               "overlay2": "#${colorPalette.b05}",

               "peach": "#${colorPalette.b09}",
               "pink": "#${colorPalette.b0E}",

               "rosewater": "#${colorPalette.b06}",

               "subtext0": "#${colorPalette.b04}",
               "subtext1": "#${colorPalette.b05}",

               "surface0": "#${colorPalette.b01}",
               "surface1": "#${colorPalette.b02}",
               "surface2": "#${colorPalette.b03}",

               "text": "#${colorPalette.b05}",
               "white": "#${colorPalette.b07}",
               "yellow": "#${colorPalette.b0A}"
            },

            "blocks": [
              {
                "type": "prompt",
                "alignment": "left",
                "segments": [
                  {
                    "type": "session",
                    "style": "plain",
                    "template": "{{ if .SSHSession }}{{ .UserName }}@{{ .HostName }} -- {{ end }}",
                    "foreground": "p:overlay2"
                  },
                  {
                    "type": "path",
                    "style": "plain",
                    "template": "{{ .Path }} ",
                    "foreground": "p:text",
                    "properties": {
                      "style": "full"
                    }
                  }
                ]
              },
              {
                "type": "prompt",
                "alignment": "right",
                "filler": "─",
                "overflow": "hide",
                "segments": [
                  {
                    "type": "git",
                    "style": "plain",
                    "foreground": "p:blue",
                    "template": " {{ .HEAD }}{{ if gt .Working.Modified 0 }}  {{ .Working.Modified }}{{ end }}{{ if gt .Staging.Modified 0 }}  {{ .Staging.Modified }}{{ end }}{{ if gt .StashCount 0 }}  {{ .StashCount }}{{ end }}",
                    "options": {
                      "fetch_status": true,
                      "fetch_upstream_icon": true,
                      "source": "cli"
                    }
                  },
                  {
                    "type": "aws",
                    "style": "plain",
                    "template": " aws {{ .Profile }}",
                    "foreground": "p:peach"
                  },
                  {
                    "type": "gcp",
                    "style": "plain",
                    "template": " gcp {{ .Active }}",
                    "foreground": "p:blue"
                  },
                  {
                    "type": "go",
                    "style": "plain",
                    "template": " go {{ .Full }}",
                    "foreground": "p:cyan"
                  },
                  {
                    "type": "node",
                    "style": "plain",
                    "template": " node {{ .Full }}",
                    "foreground": "p:green"
                  },
                  {
                    "type": "package",
                    "style": "plain",
                    "template": " package {{ .Full }}",
                    "foreground": "p:pink"
                  },
                  {
                    "type": "python",
                    "style": "plain",
                    "template": " py {{ .Full }}",
                    "foreground": "p:yellow"
                  },
                  {
                    "type": "rust",
                    "style": "plain",
                    "template": " rs {{ .Full }}",
                    "foreground": "p:peach"
                  },
                  {
                    "type": "terraform",
                    "style": "plain",
                    "template": " tf {{ .WorkspaceName }}",
                    "foreground": "p:blue"
                  },
                  {
                    "type": "nix-shell",
                    "style": "plain",
                    "template": "{{ if .Env.IN_NIX_SHELL }} ── 󱄅-{{ .Env.IN_NIX_SHELL }}{{ end }}",
                    "foreground": "p:blue"
                  },
                  {
                    "type": "time",
                    "style": "plain",
                    "template": " ── {{ .CurrentDate | date \"2006-01-02\" }} ── {{ .CurrentDate | date \"15:04:05\" }}",
                    "foreground": "p:overlay1"
                  }
                ]
              },

              {
                "type": "prompt",
                "alignment": "left",
                "newline": true,
                "segments": [
                  {
                    "type": "text",
                    "style": "plain",
                    "foreground": "p:green",
                    "template": "[@] "
                  }
                ]
              }
            ],

            "console_title_template": "{{ .Folder }}",

            "transient_prompt": {
              "template": "[@] ",
              "foreground": "p:green"
            },

            "secondary_prompt": {
              "template": "[@] ",
              "foreground": "p:green"
            },

            "final_space": true
          }
        '';
      };
    };
}
