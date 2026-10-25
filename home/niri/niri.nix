# niri, user side. The session itself is registered in modules/desktop (the
# login screen needs it); config.kdl is linked in home/link.nix.
{ pkgs, ... }:
{
  # X11 apps (Steam, many games) run through this; niri starts it on demand.
  home.packages = [ pkgs.xwayland-satellite ];

  # Electron/Chromium apps (Discord, VS Code, ...) run natively on Wayland.
  home.sessionVariables.NIXOS_OZONE_WL = "1";
}
