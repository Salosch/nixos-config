function mesa-version --description 'Check OpemGL/Mesa Versions'
    nix shell nixpkgs#mesa-demos -c glxinfo -B
end
