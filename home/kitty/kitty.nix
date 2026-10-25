# kitty. Its kitty.conf is linked in home/link.nix.
{ pkgs, ... }:
{
  home.packages = [ pkgs.kitty ];
}
