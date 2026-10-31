function full-rebuild --description 'Update the flake inputs in ~/nixos, then rebuild'
    nix flake update --flake ~/nixos
    and rebuild $argv
end
