# Every config file in this repo, linked to the place its program reads it from.
# The links point straight at the files in ~/nixos, so saving a file applies it
# at once, no rebuild. New config file? Add one line here.
{ config, flakeDir, ... }:
let
  link = file: config.lib.file.mkOutOfStoreSymlink "${flakeDir}/home/${file}";
in
{
  xdg.configFile = {
    "niri/config.kdl".source = link "niri/config.kdl";
    "kitty/kitty.conf".source = link "kitty/kitty.conf";
    "noctalia/config.toml".source = link "noctalia/config.toml";
    # Palettes you save in Noctalia's Settings. Whole folder, so new ones need no line
    # (don't also use programs.noctalia.customPalettes: it can't write into a linked folder).
    "noctalia/palettes".source = link "noctalia/palettes";
    "noctalia/templates".source = link "noctalia/templates";

    # fish: Home Manager writes ~/.config/fish/config.fish itself (it loads your
    # session variables), and fish also reads every file in conf.d, so yours goes there.
    "fish/conf.d/config.fish".source = link "fish/config.fish";

    # fish functions are not linked here: home/fish/fish.nix adds the repo
    # folder to fish's search path instead (see there for why).
  };

  # Noctalia's Settings window writes every change into ~/.local/state/noctalia/settings.toml.
  # Linked into the repo, so those changes land in git right away (Noctalia writes
  # through the link). The repo file must exist, even empty, or the write fails.
  xdg.stateFile."noctalia/settings.toml".source = link "noctalia/settings.toml";
}
