# nixos

NixOS 26.05 (stable) config: flakes, Home Manager (as a NixOS module), niri + Noctalia v5,
SDDM, fish, GRUB for dual boot with Windows. Noctalia follows unstable through its own flake.

## Layout

Every `default.nix` only imports; the actual settings are in the file next to it.

```
flake.nix                 inputs, username/hostname, pkgs-unstable, Home Manager wiring
hosts/<hostname>/
  default.nix             this machine = the installer's two files + the system modules it uses
  configuration.nix       copied from /etc/nixos after installing (hostname, locale, keyboard, user)
  hardware-configuration.nix   copied from /etc/nixos after installing
modules/                  system level: root, every user, and Steam
  boot/boot.nix           GRUB with os-prober: NixOS and Windows in one boot menu
  core/core.nix           Nix settings, cleanup, unfree
  desktop/desktop.nix     niri session, SDDM, AMD graphics, audio, services, base fonts
  fish/fish.nix           fish as your login shell
  gaming/gaming.nix       Steam (+ GE-Proton, firewall, 32-bit drivers, controller rules), GameMode, gamescope
home/                     user level (Home Manager): every other app and its config
  default.nix             lists everything below
  home.nix                apps without config (incl. Prism Launcher, MangoHud), fonts, cursor
  link.nix                every config file in this repo → its place in ~/.config
  fish/fish.nix           fish, functions/ on fish's search path, plugins (fishPlugins.*)   + config.fish, functions/ (rebuild.fish)
  niri/niri.nix           xwayland-satellite, Wayland env   + config.kdl
  noctalia/noctalia.nix   Noctalia from its flake   + config.toml (by hand), settings.toml (its Settings window), palettes/
  kitty/kitty.nix         kitty   + kitty.conf
  git/git.nix             git + GitHub CLI
```

## Where does a new thing go?

| It is…                                        | Put it in                                                              |
| --------------------------------------------- | ---------------------------------------------------------------------- |
| an app with no config                         | `home/home.nix` → `home.packages`                                      |
| an app with a config file or settings         | `home/<app>/default.nix` (imports) + `home/<app>/<app>.nix` (settings) + its config file; add the folder to `home/default.nix` and the file to `home/link.nix` |
| an app that needs a newer version than stable | `pkgs-unstable.<name>` instead of `pkgs.<name>`                        |
| something that needs root (service, driver, udev, firewall) | `modules/<topic>/default.nix` + `<topic>.nix`, add it to `hosts/<hostname>/default.nix` |

Files linked in `home/link.nix` are live: saving them applies the change, no rebuild.
That includes Noctalia's Settings window: it writes into `home/noctalia/settings.toml`,
so its changes show up in `git status` right away.
fish searches `home/fish/functions` in the repo directly (`fish_function_path`, set in
`home/fish/fish.nix`), so a new `home/fish/functions/<name>.fish` needs no extra line.

New files must be `git add`-ed before rebuilding. Flakes only see files git knows about.

## Commands

```
rebuild                                 # = sudo nixos-rebuild switch --flake ~/nixos (fish function)
nix flake update --flake ~/nixos        # update all inputs, then `rebuild` and commit flake.lock
sudo nixos-rebuild switch --rollback    # back to the previous generation
```
