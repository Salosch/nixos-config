# Your user: apps without config, fonts, cursor.
#
# Rule of thumb:
#   app needs no config         → one line in home.packages below
#   app needs config / files    → its own folder in home/ (listed in home/default.nix),
#                                 its config file linked in home/link.nix
#   app needs a newer version   → pkgs-unstable.<name> instead of pkgs.<name>
{
  pkgs,
  pkgs-unstable,
  username,
  osConfig,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    firefox
    nautilus # file manager (niri also uses it for file-open dialogs)
    kdePackages.kate # text editor
    btop
    fastfetch
    vim
    wget
    curl
    prismlauncher # Minecraft
    mangohud # FPS overlay, Steam launch option: `mangohud %command%`
    vesktop
    pkgs-unstable.fetch
  ];

  # Same cursor in every app (niri sets it too, in config.kdl).
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
  };

  # Without this, `gtk.enable` in the cursor block above does nothing: Home Manager
  # only writes GTK's cursor settings (settings.ini files + dconf keys) when it's on.
  gtk.enable = true;

  # Plasma (the fallback session) replaces ~/.gtkrc-2.0 with its own file at every
  # login. Without this, a rebuild after a Plasma login fails as soon as an older
  # .hm-backup copy is in the way. Delete this line when you drop Plasma.
  gtk.gtk2.force = true;
  # Same for GTK 3/4's settings.ini (no gtk3/gtk4 switch exists, so set it on the files).
  # Safe with niri and Noctalia: neither writes these files; Noctalia's GTK theming
  # uses gtk.css and noctalia.css instead. Delete these too when you drop Plasma.
  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;

  # Follows system.stateVersion in hosts/<hostname>/configuration.nix.
  home.stateVersion = osConfig.system.stateVersion;
}
