# Steam and the tools it launches games with, set up at system level.
# programs.steam also brings the 32-bit graphics drivers and controller udev rules.
{ pkgs, username, ... }:
{
  programs.steam = {
    enable = true;
  };

  # Steam launch options: `gamemoderun %command%`, `gamescope -f -- %command%`
  programs.gamemode.enable = true;

  # GameMode may only switch the CPU governor etc. for members of this group
  # (its polkit actions are denied for everyone else). Merges with the
  # installer's extraGroups.
  users.users.${username}.extraGroups = [ "gamemode" ];
}
