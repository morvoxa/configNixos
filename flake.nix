{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      flake-parts,
      nixpkgs,
      rust-overlay,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      flake = {
        nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
          modules = [
            ./configuration.nix
            ({ pkgs, ... }: {
              nixpkgs.overlays = [ rust-overlay.overlays.default ];
              environment.systemPackages = [
                pkgs.rust-bin.stable.latest.default
                pkgs.rust-bin.stable.latest.rust-analyzer
              ];
            })
            ./src/dwm.nix
            ./src/neovim.nix
          ];
        };
      };
    };
}
