{
  config,
  pkgs,
  inputs,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};


  noctaliaColors = "${config.xdg.configHome}/spicetify/noctalia.css";
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;

    spotifyPackage = pkgs.spotify.overrideAttrs (old: {
      postFixup = (old.postFixup or "") + ''
        ln -sf ${noctaliaColors} $out/share/spotify/Apps/xpui/colors.css
      '';
    });

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
      {
        src = ./.;
        name = "noctalia-colors.js";
      }
    ];
  };
}
