# System side of the desktop: what needs root or serves every user
# (session, login screen, drivers, background services). The apps, their
# configs and Noctalia itself live in home/.
{ ... }:
{
  # ── Compositor ──────────────────────────────────────────────────────
  # Registers the niri session for the login screen, plus portals, polkit and gnome-keyring.
  programs.niri.enable = true;

  # ── Login screen ────────────────────────────────────────────────────
  # SDDM on Wayland (it runs inside Weston). It lists the niri session, takes the
  # keyboard layout from services.xserver.xkb in the installer's configuration.nix,
  # and unlocks gnome-keyring at login (Noctalia keeps its clipboard key there).
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "niri";

  # ── Graphics (AMD) ──────────────────────────────────────────────────
  # Mesa is all an AMD card needs. The 32-bit part for Steam is in modules/gaming.
  hardware.graphics.enable = true;

  # ── Services Noctalia's widgets talk to ─────────────────────────────
  networking.networkmanager.enable = true; # Wi-Fi / network widget
  hardware.bluetooth.enable = true; # Bluetooth widget
  services.upower.enable = true; # battery widget
  services.power-profiles-daemon.enable = true; # power profile widget

  # ── Audio ───────────────────────────────────────────────────────────
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Trash, USB drives and network shares in the file manager.
  services.gvfs.enable = true;

  # Base fonts for every user, including the login screen. Your own fonts are in home/home.nix.
  fonts.enableDefaultPackages = true;
}
