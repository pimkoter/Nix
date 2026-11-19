{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.kanata-no-hrm = moduleWithSystem (
    { self', ... }: {
      environment = {
        systemPackages = [ self'.packages.kanata-no-hrm ];
      };

      systemd.user.services.kanata-no-hrm = {
        description = "Kanata without home-row mods";

        wantedBy = [ "default.target" ];

        serviceConfig = {
          ExecStart = "${self'.packages.kanata-no-hrm}/bin/kanata";
          Restart = "on-failure";
        };
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
        kanata-no-hrm = inputs.wrappers.lib.wrapPackage {
          inherit pkgs;
          package = pkgs.kanata;
          flags = {
            "-c" = pkgs.writeText "kanata.kbd" ''
              (defcfg
                #
                #
                # TODO:
                # edit linux-dev-names-include to exclude for custom Keyboard
                #
                #
                linux-dev-names-include
                (
                  "AT Translated Set 2 keyboard"
                )
              )

              (defvar
                tap-time 200
                hold-time 250
              )

              (defalias
                norepeat kana

                meh
                  (multi
                    lctl
                    lalt
                    lsft
                  )

                esc
                  (multi
                    @norepeat
                    (tap-hold-release
                      $tap-time
                      $hold-time
                      esc
                      (multi
                        @meh
                        (layer-while-held esc-navigation)
                      )
                    )
                  )

              )

              (defsrc
                esc

                grv  1 2 3 4 5 6 7 8 9 0 - = bspc

                tab  q w e r t y u i o p [ ] \

                caps a s d f g h j k l ; ' ret

                lsft 102d z x c v b n m , . / rsft

                lctl lmet lalt spc ralt rmet rctl
              )

              (deflayer qwerty
                caps

                grv  1 2 3 4 5 6 7 8 9 0 - = bspc

                tab  q w e r t y u i o p [ ] \

                @esc a s d f g h j k l ; ' ret

                lsft 102d z x c v b n m , . / rsft

                lctl lmet lalt spc ralt rmet rctl
              )

              (deflayer navigation
                _

                _ _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ left down up right _ _ _

                _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ _
              )

              (deflayer esc-navigation
                _

                _ _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ m n e i _ _ _

                _ _ _ _ _ _ _ _ _ _ _ _ _

                _ _ _ _ _ _ _
              )
            '';
          };
        };
      };
    };
}
