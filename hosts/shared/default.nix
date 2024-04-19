{ pkgs, ... }:

{
  imports = [
    ./packages.nix

    ../../modules/apps/cli/zsh.nix
  ];

  environment.pathsToLink = [ "/share/zsh" ]; # Link zsh completions

  # Nix options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Time options
  time = {
    timeZone = "Asia/Qyzylorda";
    hardwareClockInLocalTime = true;
  };

  programs.dconf.enable = true; # Fix missing cursors on Firefox

  virtualisation.docker.enable = true;

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