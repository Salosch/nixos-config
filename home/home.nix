{
  pkgs,
  pkgs-unstable,
  inputs,
  username,
  osConfig,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";

  home.packages = with pkgs; [
    firefox
    nautilus
    kdePackages.kate
    fastfetch
    wget
    curl
    mangohud
    mission-center
    ffmpeg
    trash-cli
    simple-scan

    pkgs-unstable.vesktop
    pkgs-unstable.fetch
    pkgs-unstable.linux-wallpaperengine

    inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.claude-desktop

    (prismlauncher.overrideAttrs (old: {
      qtWrapperArgs = old.qtWrapperArgs ++ [ "--set SDL_VIDEO_DRIVER wayland" ];
    }))

  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.runCommand "catppuccin-velvet-deep" { } ''
      mkdir -p $out/share/icons
      tar -xzf ${./cursor/Catppuccin-Velvet-Deep.tar.gz} -C $out/share/icons
    '';
    name = "Catppuccin-Velvet-Deep";
    size = 24;
    gtk.enable = true;
  };

  gtk.enable = true;
  gtk.gtk2.force = true;

  xdg.configFile."gtk-3.0/settings.ini".force = true;
  xdg.configFile."gtk-4.0/settings.ini".force = true;

  home.stateVersion = osConfig.system.stateVersion;
}
