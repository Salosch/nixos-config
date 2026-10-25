# "rebuild" = apply the NixOS config in ~/nixos.
# Extra flags are passed on, e.g. `rebuild --show-trace`.
function rebuild --description 'Apply the NixOS config in ~/nixos'
    sudo nixos-rebuild switch --flake ~/nixos $argv
end
