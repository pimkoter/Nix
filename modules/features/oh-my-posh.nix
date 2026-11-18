{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.oh-my-posh = moduleWithSystem (
    { self', ... }: {
      environment.systemPackages = [ self'.packages.oh-my-posh ];
    }
  );

  perSystem =
    {
      pkgs,
      self',
      lib,
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
              "background": "#1e1e2e",
              "base": "#1e1e2e",
              "blue": "#89b4fa",
              "comment": "#6c7086",
              "crust": "#11111b",
              "current_line": "#313244",
              "cyan": "#89dceb",
              "flamingo": "#f2cdcd",
              "foreground": "#cdd6f4",
              "green": "#a6e3a1",
              "grey": "#7f849c",
              "lavender": "#b4befe",
              "mantle": "#181825",
              "maroon": "#eba0ac",
              "mauve": "#cba6f7",
              "none": "#cdd6f4",
              "orange": "#fab387",
              "overlay0": "#6c7086",
              "overlay1": "#7f849c",
              "overlay2": "#9399b2",
              "peach": "#fab387",
              "pink": "#f5c2e7",
              "purple": "#cba6f7",
              "red": "#f38ba8",
              "rosewater": "#f5e0dc",
              "sapphire": "#74c7ec",
              "sky": "#89dceb",
              "subtext0": "#a6adc8",
              "subtext1": "#bac2de",
              "surface0": "#313244",
              "surface1": "#45475a",
              "surface2": "#585b70",
              "teal": "#94e2d5",
              "text": "#cdd6f4",
              "white": "#cdd6f4",
              "yellow": "#f9e2af"
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
                    "foreground": "p:lavender",
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
                    "foreground": "p:sky"
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
                    "foreground": "p:lavender"
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
