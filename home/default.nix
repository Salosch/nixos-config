# Home Manager entry point: only lists the files and folders that make up your user.
{
  imports = [
    ./home.nix
    ./link.nix

    ./fish
    ./niri
    ./noctalia
    ./kitty
    ./git
  ];
}
