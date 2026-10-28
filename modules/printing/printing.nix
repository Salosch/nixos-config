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
    extraBackends = [
      pkgs.hp-unified-linux-driver
      (pkgs.writeTextDir "etc/sane.d/escl.conf" ''
        device https://192.168.178.29:631 "HP Laser MFP 137fwg"
      '')
    ];
  };

  users.users.${username}.extraGroups = [ "scanner" "lp" ];
}
