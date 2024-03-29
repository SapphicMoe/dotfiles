{ pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../shared

      ../../modules/system/graphics.nix
      
      ../../modules/services/asusd.nix
      ../../modules/services/pipewire.nix
      ../../modules/services/xserver.nix

      ../../modules/cli-apps/1password

      ../../modules/apps/1password
      ../../modules/apps/steam

      inputs.home-manager.nixosModules.default
    ];

  networking.hostName = "sapphic";
  
  environment = {
    systemPackages = with pkgs; [
      asusctl
      catppuccin-sddm-corners
      catppuccin-cursors.mochaPink
    ];
  };

  virtualisation.docker = {
    enable = true;
  };

  system.stateVersion = "23.11"; # Initial NixOS version
}
