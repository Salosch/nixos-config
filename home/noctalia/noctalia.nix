# Noctalia from its own flake. `settings` stays unset on purpose: then the
# module writes no config file, and home/link.nix links the files in this folder.
#
# All of them are linked live into this repo, so nothing needs exporting:
#   config.toml    what you write by hand
#   settings.toml  what Noctalia's Settings window writes (every change lands here at once)
#   palettes/      colour palettes you save in its Settings
# settings.toml loads last, so it wins when both files set the same thing.
{ inputs, ... }:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia.enable = true;
}
