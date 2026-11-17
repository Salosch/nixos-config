{ config, flakeDir, ... }:
let
  link = file: config.lib.file.mkOutOfStoreSymlink "${flakeDir}/home/${file}";
in
{
  xdg.configFile = {
    "niri/config.kdl".source = link "niri/config.kdl";
    "kitty/kitty.conf".source = link "kitty/kitty.conf";
    "noctalia/config.toml".source = link "noctalia/config.toml";

    "noctalia/palettes".source = link "noctalia/palettes";
    "noctalia/templates".source = link "noctalia/templates";

    "fish/conf.d/config.fish".source = link "fish/config.fish";
    "gtk-4.0/gtk.css".source = link "gtk/gtk.css";
  };

  xdg.stateFile."noctalia/settings.toml".source = link "noctalia/settings.toml";
}
