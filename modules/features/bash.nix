{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.bash = moduleWithSystem (
    { self', ... }: {
      nixpkgs.overlays = [
        (_: _: {
          bashInteractive = self'.packages.bash;
        })
      ];

      environment.shells = [ self'.packages.bash ];
      users.defaultUserShell = self'.packages.bash;
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
              if [[ $- == *i* && -z "$DEVENV_CMDLINE" ]]; then
                ${lib.getExe self'.packages.fastfetch}

                if [[ -z "$HERDR_ENV" ]]; then
                  exec ${lib.getExe self'.packages.herdr}
                fi
              fi

              HISTFILESIZE=100000
              HISTSIZE=10000

              PROMPT_COMMAND="history -a; history -n''${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

              shopt -s histappend
              shopt -s extglob
              shopt -s globstar
              shopt -s checkjobs

              # Fastfetch
              alias ff="${lib.getExe' pkgs.ncurses "clear"} && ${lib.getExe self'.packages.fastfetch}"

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
              alias nd="${lib.getExe pkgs.nix} develop"
              alias nfc="${lib.getExe pkgs.nix} flake check"
              alias gens='sudo nixos-rebuild list-generations'
              nr() {
                local package="$1"
                shift
                ${lib.getExe pkgs.nix} run "nixpkgs#$package" -- "$@"
              }

              # Init on startup
              eval "$(${lib.getExe self'.packages.oh-my-posh} init bash)"
              eval "$(${lib.getExe pkgs.zoxide} init bash --cmd cd)"
              eval "$(${lib.getExe self'.packages.atuin} init bash)"

              # Devenv
              _my_rcfile=''${BASH_SOURCE[0]}
              devenv() {
                if [[ "$*" == shell ]]; then
                  command env _MY_RC="$_my_rcfile" PROMPT_COMMAND='[[ -z $_MY_RC ]] || . "$_MY_RC"' ${lib.getExe pkgs.devenv} shell
                else
                  command ${lib.getExe pkgs.devenv} "$@"
                fi
              }

              eval "$(${lib.getExe pkgs.devenv} hook bash)"

              if [[ -n "$_MY_RC" ]]; then
                unset _MY_RC
                export -n PROMPT_COMMAND
                for _cmd in "''${PROMPT_COMMAND[@]}"; do eval "$_cmd"; done
              fi
            '';
          };
        };
      };
    };
}
