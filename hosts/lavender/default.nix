{
  imports = [
    ./hardware.nix
  ];

  settings = {
    flatpak.enable = false;

    scripts.enable = true;
  };

  networking.wireless.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "23.11"; # Initial NixOS version
}
