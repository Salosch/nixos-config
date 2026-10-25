# fish as your login shell. That part is system-level (/etc/shells, your user
# account); fish's own settings are in home/fish.
{ pkgs, username, ... }:
{
  # Registers fish as a valid shell and gives it NixOS's paths and completions.
  programs.fish.enable = true;

  users.users.${username}.shell = pkgs.fish;
}
