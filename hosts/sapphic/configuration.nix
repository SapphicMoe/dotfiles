{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared

    ../../modules/system/asus.nix
    ../../modules/system/audio.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/kde.nix
    ../../modules/system/graphics.nix

    ../../modules/apps/gui/1password.nix
    ../../modules/apps/gui/steam.nix
  ];

  networking.networkmanager.enable = true;

  system.stateVersion = "23.11"; # Initial NixOS version
}
