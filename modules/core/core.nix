# Nix itself and cleanup. No apps live here.
{ ... }:
{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;


    extra-substituters = [
      "https://noctalia.cachix.org"
      "https://cache.numtide.com"
    ];

    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
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
