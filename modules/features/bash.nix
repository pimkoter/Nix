{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.bash = moduleWithSystem (
    { self', ... }: {
      environment = {
        systemPackages = [ self'.packages.bash ];
      };
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
        bash = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          passthru.shellPath = pkgs.bash.shellPath;
          package = pkgs.bashInteractive;
          flags = {
            "--rcfile" = pkgs.writeText "bashrc" ''
              # Startup
              if [[ $- == *i* ]]; then
                ${lib.getExe pkgs.fastfetch}

                if [[ -z "$HERDR_ENV" ]]; then
                  exec ${lib.getExe self'.packages.herdr}
                fi
              fi

              HISTFILESIZE=100000
              HISTSIZE=10000

              PROMPT_COMMAND="history -a; history -n"

              shopt -s histappend
              shopt -s extglob
              shopt -s globstar
              shopt -s checkjobs

              # Fastfetch
              alias ff="${lib.getExe' pkgs.ncurses "clear"} && ${lib.getExe pkgs.fastfetch}"

              # Lazygit
              alias lg=${lib.getExe self'.packages.lazygit}

              # Replace cat with bat
              alias cat=${lib.getExe pkgs.bat}

              # Vim aliases
              alias v=${lib.getExe self'.packages.neovim}
              alias sv="sudo ${lib.getExe self'.packages.neovim}"

              # System shorthand
              alias c=${lib.getExe' pkgs.ncurses "clear"}
              alias e=exit # Builtin bash function
              alias srn="sudo reboot now"

              # Changing to git root
              alias cg="cd '$(${lib.getExe pkgs.git} rev-parse --show-toplevel 2>/dev/null)'"

              # Eza stuff
              alias la="${lib.getExe self'.packages.eza} -lah --no-git"
              alias ll="${lib.getExe self'.packages.eza} -lh --no-user"
              alias ls=${lib.getExe self'.packages.eza}
              alias tree="${lib.getExe self'.packages.eza} --no-git --tree"

              # Nix aliases
              alias nd="${lib.getExe pkgs.nix} develop --impure"
              alias nr="${lib.getExe pkgs.nix} run nixpkgs#"
              alias gens='sudo nixos-rebuild list-generations'

              # Init on startup
              eval "$(${lib.getExe self'.packages.oh-my-posh} init bash)"
              eval "$(${lib.getExe pkgs.zoxide} init bash --cmd cd)"
              eval "$(${lib.getExe self'.packages.atuin} init bash)"
            '';
          };
        };
      };
    };
}
