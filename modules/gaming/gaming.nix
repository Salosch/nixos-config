{ pkgs, inputs ,username, ... }:

{

  nixpkgs.overlays = [ inputs.millennium.overlays.default ];

  programs.steam = {
    enable = true;
    package = pkgs.millennium-steam;
    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };


  programs.gamemode.enable = true;


  # This is necessary for joining Minecraft servers running large modpacks like atm10
  # Otherwise linux will refuse the connection
  boot.kernel.sysctl."net.ipv4.tcp_mtu_probing" = 1;

  users.users.${username}.extraGroups = [ "gamemode" ];
}
