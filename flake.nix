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

    # Catppuccin for Nix
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = {
    self,
    home-manager,
    nixpkgs,
    ...
  } @ inputs:
  # let
  #   system = "x86_64-linux";
  #   pkgs = nixpkgs.legacyPackages.${system};
  # in
  {
    # NixOS configuration
    nixosConfigurations = {
      "sapphic" = let
        hostname = "sapphic";
        username = "chloe";
      in
        nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            ./hosts/${hostname}/configuration.nix

            home-manager.nixosModules.home-manager
            {
              networking.hostName = hostname;

              home-manager = {
                extraSpecialArgs = {inherit inputs;};
                users.${username} = {
                  imports = [./home/${username}/home.nix];
                  home = {
                    inherit username;
                    homeDirectory = "/home/${username}";
                  };
                };
              };
            }
          ];
        };
    };
  };
}
