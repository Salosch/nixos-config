{ ... }:
{

  programs.niri.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };
  services.displayManager.defaultSession = "niri";


  hardware.graphics.enable = true;

  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    wireplumber.extraConfig."51-disable-webcam-mic" = {
      "monitor.alsa.rules" = [
        {
          matches = [ { "device.name" = "alsa_card.usb-SunplusIT_Inc_FHD_Camera_Microphone_01.00.00-02"; } ];
          actions.update-props."device.disabled" = true;
        }
      ];
    };
  };

  services.gvfs.enable = true;

  fonts.enableDefaultPackages = true;
}
