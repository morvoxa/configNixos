{
  description = "Description for the project";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = inputs@{ flake-parts,nixpkgs, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" "x86_64-darwin" ];
      flake = {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem{
      modules = [
      ./configuration.nix
      ./dwm.nix
      ];
      };
      };
    };
}
