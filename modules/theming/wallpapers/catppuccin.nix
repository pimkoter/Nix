{
  perSystem = { pkgs, ... }: {
    packages.wallpapers-catppuccin = pkgs.fetchFromGitHub {
      owner = "orangci";
      repo = "walls-catppuccin-mocha";
      rev = "master";
      hash = "sha256-N+MZHSRcwOldS5Ai8B3YfKquKs9oeUW/GkV1iKM5+i8=";
    };
  };
}
