{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../shared

    # ../../modules/system/bootloader.nix
  ];

  networking = {
    hostName = "lavender";
    wireless.enable = true;
  };

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Initial NixOS version
}