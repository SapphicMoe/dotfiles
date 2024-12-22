{
  description = "NixOS configuration for the Sapphic Angels system.";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs2311.url = "github:NixOS/nixpkgs/nixos-23.11";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin theme
    catppuccin.url = "github:catppuccin/nix";

    # Nix Language Server
    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nix-ld-rs
    nix-ld-rs = {
      url = "github:nix-community/nix-ld-rs";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # NixOS on WSL
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Fingerprint sensor for ThinkPad
    nixos-06cb-009a-fingerprint-sensor = {
      url = "github:ahbnr/nixos-06cb-009a-fingerprint-sensor";
      inputs.nixpkgs.follows = "nixpkgs2311";
    };
  };

  outputs = inputs @ { 
    self,
    nixpkgs,
    catppuccin,
    home-manager, 
    nixos-hardware,
    nixos-wsl,
    nixos-06cb-009a-fingerprint-sensor,
    ...
  }: let
    inherit (self) outputs;

    lib = nixpkgs.lib // home-manager.lib;

    systems = [
      "x86_64-linux"
      "aarch64-linux"
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
        eris = lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-06cb-009a-fingerprint-sensor.nixosModules.open-fprintd
            nixos-06cb-009a-fingerprint-sensor.nixosModules.python-validity
            catppuccin.nixosModules.catppuccin
            ./hosts/eris/configuration.nix
          ];
        };

        lavender = lib.nixosSystem {
          pkgs = pkgsFor.aarch64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-hardware.nixosModules.raspberry-pi-4
            ./hosts/lavender/configuration.nix
          ];
        };

        sapphic = lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            catppuccin.nixosModules.catppuccin
            ./hosts/sapphic/configuration.nix
          ];
        };

        solstice = lib.nixosSystem {
          pkgs = pkgsFor.x86_64-linux;
          specialArgs = { inherit inputs outputs; };
          modules = [
            nixos-wsl.nixosModules.default
            catppuccin.homeManagerModules.catppuccin
            ./hosts/solstice/configuration.nix
          ];
        };
      };

      # Home Manager configurations
      homeConfigurations = {
        "chloe@eris" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            catppuccin.homeManagerModules.catppuccin
            ./home/chloe/eris.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };

        "chloe@lavender" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.aarch64-linux;
          modules = [
            ./home/chloe/lavender.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
        
        "chloe@sapphic" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            catppuccin.homeManagerModules.catppuccin
            ./home/chloe/sapphic.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };

        "chloe@solstice" = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = pkgsFor.x86_64-linux;
          modules = [
            catppuccin.nixosModules.catppuccin
            ./home/chloe/solstice.nix
          ];
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
