{ config, pkgs, ... }:

{

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "uwumachine";


  time.timeZone = "Europe/Berlin";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "de";
    variant = "";
  };

  services.keyd = {
  enable = true;
  keyboards.default = {
   ids = [ "*" ];
   extraConfig = ''
     [control+alt]
       q = G-q
       e = G-e
       2 = G-2
       3 = G-3
       7 = G-7
       8 = G-8
       9 = G-9
       0 = G-0
       minus = G-minus
       rightbrace = G-rightbrace
       m = G-m
     '';
    };
  };


  console.keyMap = "de";

  users.users."milas" = {
    isNormalUser = true;
    description = "Salim";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  system.stateVersion = "26.05";

}
