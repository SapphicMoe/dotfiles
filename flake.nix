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

  outputs = { self, home-manager, nixpkgs, ... } @inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # NixOS configurations
      nixosConfigurations = {
        sapphic = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            ./hosts/sapphic/configuration.nix
          ];
        };
      };

      # Home Manager configurations
      homeConfigurations = let
        username = "chloe";
      in {
        "${username}" = home-manager.lib.homeManagerConfiguration {
          pkgs = pkgs;
          extraSpecialArgs = { inherit inputs; };
          modules = [
            ./home/${username}/home.nix
            ({ pkgs, ... }: {
              home = {
                username = username;
                homeDirectory = "/home/${username}";
              };
            })
          ];
        };
      };
    };
    
}
