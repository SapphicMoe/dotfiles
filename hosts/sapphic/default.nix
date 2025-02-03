{
  imports = [
    ./hardware.nix
  ];

  networking.networkmanager.enable = true;

  settings = {
    kde.enable = true;
    gui.enable = true;
    bootloader.enable = true;

    hardware = {
      nvidia.enable = true;
      asus.enable = true;
      audio.enable = true;
    };
  };

  system.stateVersion = "23.11"; # Initial NixOS version
}
