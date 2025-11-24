{
  description = "Machine Learning utilities for running LLMs locally";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    claude-desktop.url = "github:k3d3/claude-desktop-linux-flake";
  };
  outputs = { self, nixpkgs, claude-desktop }: {
    homeManagerModules.default = { pkgs, lib, config, ... }:
      import ./home-module.nix {
        pkgs = import nixpkgs {
          system = pkgs.system;
          config.allowUnfree = true;
        };
        inherit lib config;
        claude-desktop = claude-desktop;
      };

    nixosModules.default = { pkgs, lib, config, ... }:
      import ./nixos-module.nix {
        pkgs = nixpkgs.legacyPackages.${pkgs.system};
        inherit lib config;
      };
  };
}
