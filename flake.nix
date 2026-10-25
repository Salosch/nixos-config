{
  description = "Meister's NixOS config: flakes + Home Manager + niri + Noctalia";

  inputs = {
    # Stable NixOS. flake.lock pins the exact commit until you run `nix flake update`.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Unstable, only for the apps that need it (see pkgs-unstable below).
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05"; # must match the NixOS release
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Noctalia v5. It brings its own pinned nixos-unstable, and the `cachix` branch
    # is always prebuilt. No `follows` on purpose: overriding its nixpkgs would
    # change the hash and force a local compile.
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      ...
    }@inputs:
    let
      # ── Change these two to match your install ─────────────────────────
      username = "milas"; # must match users.users.<name> in hosts/<hostname>/configuration.nix
      hostname = "uwumachine"; # must match networking.hostName there; also its folder in hosts/
      # ───────────────────────────────────────────────────────────────────

      system = "x86_64-linux";
      flakeDir = "/home/${username}/nixos"; # where this repo lives

      # For a single app from unstable, write `pkgs-unstable.<name>` instead of `pkgs.<name>`.
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      args = {
        inherit
          inputs
          username
          flakeDir
          pkgs-unstable
          ;
      };
    in
    {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        specialArgs = args;
        modules = [
          # System level: this machine's files + the modules it uses (see hosts/<hostname>/default.nix).
          ./hosts/${hostname}

          # User level: everything else (see home/default.nix). Runs as part of `nixos-rebuild switch`.
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hm-backup"; # move existing files aside instead of failing
              extraSpecialArgs = args;
              users.${username} = import ./home;
            };
          }
        ];
      };
    };
}
