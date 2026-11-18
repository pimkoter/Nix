{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.starship = moduleWithSystem (
    { self', ... }: {
      programs.starship = {
        enable = true;
        package = self'.packages.starship;
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
        starship = inputs.wrappers.wrappers.starship.wrap {
          inherit pkgs;
          package = pkgs.starship;
          settings = {
            palette = "catppuccin_mocha";

            format = "$username$hostname$directory$fill[$all](overlay1)$time$line_break$character";

            # ── Shell interaction ──────────────────────────────────────────

            character = {
              success_symbol = "[@](bold green)";
              error_symbol = "[@](bold red)";
            };

            fill = {
              symbol = "─";
              style = "surface1";
            };

            # ── Context modules ────────────────────────────────────────────

            username = {
              style_user = "overlay2";
              style_root = "bold mauve";
              format = "[$user]($style)";
              show_always = false;
            };

            hostname = {
              ssh_only = true;
              style = "overlay2";
              format = "[$hostname]($style)";
              disabled = false;
            };

            directory = {
              truncation_length = 4;
              truncate_to_repo = true;
              style = "text";
              format = "[$path]($style)";
            };

            shell.disabled = true;

            # ── Time ───────────────────────────────────────────────────────

            time = {
              disabled = false;
              time_format = "%F %T";
              style = "overlay1";
              format = "[$time]($style)";
            };

            # ── Command duration ───────────────────────────────────────────

            cmd_duration = {
              min_time = 10000;
              style = "subtext0";
              format = "[⏱ $duration]($style)";
            };

            # ── Git modules ────────────────────────────────────────────────

            git_branch = {
              symbol = "git ";
              style = "lavender";
              format = "[$symbol$branch]($style)";
            };

            git_status = {
              style = "overlay2";
              format = "[$all_status$ahead_behind]($style)";
              conflicted = "≠";
              ahead = "⇡";
              behind = "⇣";
              diverged = "⇕";
              up_to_date = "";
            };

            # git_commit = {
            #   style = "overlay2";
            #   format = "[$hash]($style)";
            # };

            # git_state = {
            #   style = "overlay2";
            #   format = "[\($state( $progress_current of $progress_total)\)]($style)";
            # };

            # ── Language runtimes ──────────────────────────────────────────

            nodejs = {
              symbol = "node ";
              style = "green";
              format = "[$symbol($version )]($style)";
            };

            rust = {
              symbol = "rs ";
              style = "peach";
              format = "[$symbol($version )]($style)";
            };

            golang = {
              symbol = "go ";
              style = "sky";
              format = "[$symbol($version )]($style)";
            };

            python = {
              symbol = "py ";
              style = "yellow";
              format = "[$symbol($version )]($style)";
            };

            # ── Cloud / DevOps ─────────────────────────────────────────────

            aws = {
              symbol = "aws ";
              style = "peach";
              format = "[$symbol($profile )]($style)";
            };

            gcloud = {
              symbol = "gcp ";
              style = "blue";
              format = "[$symbol($active )]($style)";
            };

            kubernetes = {
              symbol = "k8s ";
              style = "mauve";
              format = "[$symbol\\($context\\)]($style)";
            };

            terraform = {
              symbol = "tf ";
              style = "lavender";
              format = "[$symbol($workspace)]($style)";
            };

            # ── Package management ─────────────────────────────────────────

            package = {
              symbol = "package ";
              style = "pink";
              format = "[$symbol$version]($style)";
            };

            # ── System modules ─────────────────────────────────────────────

            jobs = {
              symbol = "⚙ ";
              style = "sapphire";
              format = "[$symbol$number]($style)";
              threshold = 1;
            };

            memory_usage.disabled = true;
            battery.disabled = true;

            shlvl = {
              style = "overlay2";
              format = "[$shlvl]($style)";
              threshold = 2;
            };

            # ── Catppuccin Mocha palette ───────────────────────────────────

            palettes.catppuccin_mocha = {
              rosewater = "#f5e0dc";
              flamingo = "#f2cdcd";
              pink = "#f5c2e7";
              mauve = "#cba6f7";
              red = "#f38ba8";
              maroon = "#eba0ac";
              peach = "#fab387";
              yellow = "#f9e2af";
              green = "#a6e3a1";
              teal = "#94e2d5";
              sky = "#89dceb";
              sapphire = "#74c7ec";
              blue = "#89b4fa";
              lavender = "#b4befe";

              text = "#cdd6f4";
              subtext1 = "#bac2de";
              subtext0 = "#a6adc8";

              overlay2 = "#9399b2";
              overlay1 = "#7f849c";
              overlay0 = "#6c7086";

              surface2 = "#585b70";
              surface1 = "#45475a";
              surface0 = "#313244";

              base = "#1e1e2e";
              mantle = "#181825";
              crust = "#11111b";

              # Compatibility aliases
              grey = "#7f849c";
              none = "#cdd6f4";
              white = "#cdd6f4";
              background = "#1e1e2e";
              current_line = "#313244";
              foreground = "#cdd6f4";
              comment = "#6c7086";
              cyan = "#89dceb";
              orange = "#fab387";
              purple = "#cba6f7";
            };
          };
        };
      };
    };
}
