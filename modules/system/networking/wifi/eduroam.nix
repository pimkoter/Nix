{
  flake.nixosModules.wifi-eduroam = { config, ... }: {
    sops = {
      secrets."wifi/Eduroam/user" = { };
      secrets."wifi/Eduroam/password" = { };
      templates."eduroam.env".content = ''
        EDUROAM_USER=${config.sops.placeholder."wifi/Eduroam/user"}
        EDUROAM_PASS=${config.sops.placeholder."wifi/Eduroam/password"}
      '';
    };

    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ config.sops.templates."eduroam.env".path ];
      profiles.eduroam = {
        connection = {
          id = "eduroam";
          type = "wifi";
        };
        wifi = {
          ssid = "eduroam";
          mode = "infrastructure";
        };
        wifi-security.key-mgmt = "wpa-eap";
        "802-1x" = {
          eap = "peap";
          phase2-auth = "mschapv2";
          identity = "$EDUROAM_USER";
          password = "$EDUROAM_PASS";
          anonymous-identity = "anonymous@tudelft.nl";
          ca-cert = "/etc/ssl/certs/ca-certificates.crt";
          domain-suffix-match = "tudelft.nl";
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
      };
    };
  };
}
