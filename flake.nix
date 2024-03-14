{
  description = "NixOS configuration for the Sapphic Angels system.";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Language Server
    nil.url = "github:oxalica/nil";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    # let
    #   system = "x86_64-linux";
    #   pkgs = nixpkgs.legacyPackages.${system};
    # in
    {
      nixosConfigurations = {
        sapphic = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./machines/sapphic/configuration.nix
          ];
        };
      };
    };
}
