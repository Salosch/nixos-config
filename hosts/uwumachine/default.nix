# This machine: the installer's two files plus the system modules it uses.
{
  imports = [
    # Both copied from /etc/nixos after installing. Lines the modules below
    # already set were taken out of configuration.nix.
    ./configuration.nix
    ./hardware-configuration.nix

    ../../modules/boot
    ../../modules/core
    ../../modules/desktop
    ../../modules/fish
    ../../modules/gaming
    ../../modules/flatpak
    ../../modules/printing
    ../../modules/openrazer
  ];
}
