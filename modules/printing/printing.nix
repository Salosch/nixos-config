{ pkgs, username, ... }:

{
  services.printing = {
    enable = true;
    drivers = [ pkgs.hp-unified-linux-driver ];
  };

  services.avahi = {
    enable = true;
    nssmdns4 = true;
  };
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hp-unified-linux-driver ];
  };

  users.users.${username}.extraGroups = [ "scanner" "lp" ];
}
