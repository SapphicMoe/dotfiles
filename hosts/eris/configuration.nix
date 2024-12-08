{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared

    ../../modules/system/audio.nix
    ../../modules/system/bootloader.nix
    ../../modules/system/kde.nix

    ../../modules/apps/gui/1password.nix
    ../../modules/apps/gui/steam.nix
  ];

  environment.systemPackages = with pkgs; [
    catppuccin-sddm-corners
    catppuccin-cursors.mochaPink
  ];
  
  services.flatpak.enable = true;
  services.tailscale.enable = true;
  networking.hostName = "eris";
  networking.networkmanager.enable = true;

  # Use this when using the fingerprint sensor.
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = inputs.nixos-06cb-009a-fingerprint-sensor.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./fingerprint/calib-data.bin;
      };
    };
  };
  
  # Use this when enrolling new fingerprints.
  # services.open-fprintd.enable = true;
  # services.python-validity.enable = true;

  system.stateVersion = "23.11"; # Initial NixOS version
}
