# Boot menu: GRUB, which finds Windows with os-prober, so you pick NixOS or
# Windows at every start (UEFI dual boot). No theme or wallpaper yet.
{ lib, ... }:
{
  boot.loader = {
    # One boot loader at a time: GRUB, not systemd-boot (the installer's default).
    # mkForce keeps it off even if an installer line turning it on comes back.
    systemd-boot.enable = lib.mkForce false;

    # Lets GRUB add itself to the firmware's list of boot entries.
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev"; # UEFI: GRUB lives on the EFI partition, not on a disk's MBR
      useOSProber = true; # looks for Windows at every rebuild and adds it to the menu
      configurationLimit = 10; # NixOS generations listed in the menu
    };
  };
}
