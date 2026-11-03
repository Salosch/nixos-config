{ username, ... }:

{
  hardware.openrazer = {
    enable = true;
    users = [ username ];
    batteryNotifier.enable = false;
  };
}
