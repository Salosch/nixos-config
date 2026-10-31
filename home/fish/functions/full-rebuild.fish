function full-rebuild --description 'Go to ~/nixos, update the flake inputs, then rebuild'
    cd ~/nixos
    and nix flake update
    and rebuild $argv
end
