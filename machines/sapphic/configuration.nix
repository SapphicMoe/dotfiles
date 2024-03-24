{ pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix

      ../../modules/common/system.nix
      ../../modules/common/zsh.nix

      ../../modules/system/graphics.nix
      ../../modules/system/packages.nix
      
      ../../modules/services/asusd.nix
      ../../modules/services/pipewire.nix
      ../../modules/services/xserver.nix

      ../../modules/cli-apps/1password

      ../../modules/apps/1password
      ../../modules/apps/steam

      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "sapphic";
  time.timeZone = "Asia/Qyzylorda";
  
  environment = {
    pathsToLink = [ "/share/zsh" ]; # System package completion for zsh
    
    systemPackages = with pkgs; [
      catppuccin-sddm-corners
      catppuccin-cursors.mochaPink
    ];
  };

  programs.dconf.enable = true; # Fix missing cursors on Firefox

  virtualisation.docker = {
    enable = true;
  };

  # User account configuration
  users.users = {
    chloe = {
      isNormalUser = true;
      description = "Chloe";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = pkgs.zsh;
    };
  };

  # Home Manager
  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "chloe" = import ./home.nix;
    };
  };

  system.stateVersion = "23.11"; # Initial NixOS version
}
