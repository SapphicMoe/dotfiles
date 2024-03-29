{ pkgs, ... }:

{
  imports = [
    ./packages.nix

    ../../modules/common/zsh.nix

    ../../modules/services/pipewire.nix
    
  ];

  # Nix options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/share/zsh" ]; # Link zsh completions

  # Bootloader options
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Time options
  time = {
    timeZone = "Asia/Qyzylorda";
    hardwareClockInLocalTime = true;
  };

  programs.dconf.enable = true; # Fix missing cursors on Firefox

  networking.networkmanager.enable = true; # Enable NetworkManager

  users.users = {
    chloe = {
      isNormalUser = true;
      description = "Chloe";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = with pkgs; zsh;
    };
  };
}