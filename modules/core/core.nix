# Nix itself and cleanup. No apps live here.
{ ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    # Noctalia's binary cache, so Noctalia is downloaded instead of compiled.
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Delete generations older than two weeks, once a week.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # Allows Steam, Discord, ... Applies to Home Manager packages too.
  nixpkgs.config.allowUnfree = true;
}
