{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared

    ../../modules/system/asus.nix
    ../../modules/system/audio.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/kde.nix
    ../../modules/system/graphics.nix
    ../../modules/system/libvirt.nix

    ../../modules/apps/gui/1password.nix
    ../../modules/apps/gui/steam.nix
  ];

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    catppuccin-cursors.mochaPink
  ];
  
  services.flatpak.enable = true;


  system.stateVersion = "23.11"; # Initial NixOS version
}
