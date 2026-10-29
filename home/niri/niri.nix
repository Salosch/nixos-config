# niri, user side. The session itself is registered in modules/desktop (the
# login screen needs it); config.kdl is linked in home/link.nix.
{ pkgs, ... }:
{
  # X11 apps (Steam, many games) run through this; niri starts it on demand.
  home.packages = [
  # X11 apps (Steam, many games) run through this; niri starts it on demand.
  # Patched so Steam's notification pop-ups get a window of their own instead
  # of sticking to the Steam window (steam-toasts.patch).
  (pkgs.xwayland-satellite.overrideAttrs (old: {
    patches = (old.patches or [ ]) ++ [ ./steam-toasts.patch ];
  }))
];

  # Electron/Chromium apps (Discord, VS Code, ...) run natively on Wayland.
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
