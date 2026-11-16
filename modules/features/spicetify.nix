{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.spicetify = moduleWithSystem (
    { self', ... }:
    {
      environment.systemPackages = [
        self'.packages.spicetify
      ];
    }
  );

  perSystem = { unfreePkgs, inputs', ... }: {
    packages.spicetify =
      let
        spicePkgs = inputs'.spicetify.legacyPackages;
      in
      inputs.spicetify.lib.mkSpicetify unfreePkgs {
        enabledExtensions = with spicePkgs.extensions; [
          adblock
          hidePodcasts
          shuffle
          fullAppDisplay
          keyboardShortcut
          trashbin
          powerBar
          songStats
          volumePercentage
          beautifulLyrics
          privateSession
          aiBandBlocker
          catJamSynced
          focusMode
        ];

        enabledCustomApps = with spicePkgs.apps; [
          newReleases
          ncsVisualizer
        ];

        enabledSnippets = with spicePkgs.snippets; [
          pointer
        ];
      };
  };
}
