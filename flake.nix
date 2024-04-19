{
  description = "NixOS configuration for the Sapphic Angels system.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Language Server
    nil.url = "github:oxalica/nil";
    
    # nix-ld-rs
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS on WSL
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = inputs @ { 
    self,
    nixpkgs,
    home-manager, 
    nixos-wsl,
    ...
  }: let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;

    systems = [
      "x86_64-linux"
    ];

    # forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});

    pkgsFor = lib.genAttrs systems (system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      });
    in {
      inherit lib;

      # NixOS configurations
      nixosConfigurations = {
        sapphic = lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            ./hosts/sapphic/configuration.nix
          ];
        };

        solstice = lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-wsl.nixosModules.default
            ./hosts/solstice/configuration.nix
          ];
        };
      };

      # Home Manager configurations
      homeConfigurations = {
        "chloe@sapphic" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./home/chloe/sapphic.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };

        "chloe@solstice" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            ./home/chloe/solstice.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
