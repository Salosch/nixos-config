# fish, kept minimal: your settings (config.fish, linked in home/link.nix),
# your functions (functions/, put on fish's search path below) and a list
# for plugins. Making fish the login shell is in modules/fish.
{ pkgs, flakeDir, ... }:
let
  functions = "${flakeDir}/home/fish/functions";
in
{
  # Home Manager writes ~/.config/fish/config.fish, which loads your session
  # variables (niri inherits them through your login shell).
  programs.fish.enable = true;

  # Your functions: fish searches home/fish/functions in the repo directly, so a
  # new .fish file there works in new shells, no rebuild, no extra line.
  # (Linking the folder as ~/.config/fish/functions would break the build as soon
  # as any Home Manager module puts a function there, e.g. programs.lazygit.)
  # Set from conf.d, which fish reads before config.fish ("00-" sorts first),
  # so your config.fish can call your functions too.
  xdg.configFile."fish/conf.d/00-functions.fish".text = ''
    contains -- ${functions} $fish_function_path
    or set -p fish_function_path ${functions}
  '';

  # Fish plugins from nixpkgs, added like in github.com/Evelynnsrepos/nixsysconf.
  # One name per line; `nix search nixpkgs fishPlugins` lists them. fish loads
  # them on its own at the next shell start.
  home.packages = with pkgs.fishPlugins; [
    # autopair # closes brackets and quotes
    # fzf-fish # Ctrl+R history search etc.; also needs pkgs.fzf and pkgs.fd
  ];
}
