{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellApplication {
      name = "autoclick";
      runtimeInputs = with pkgs; [
        ydotool
        procps
        coreutils
      ];
      text = builtins.readFile ./autoclick.sh;
    })
  ];
}
