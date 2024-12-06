{ pkgs, ... }:

{
  imports = [
    ./packages.nix

    ../../modules/apps/cli/zsh.nix
  ];

  environment.pathsToLink = [ "/share/zsh" ]; # Link zsh completions

  # Nix options
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time = {
    timeZone = "Asia/Almaty";
    hardwareClockInLocalTime = true; # Keep time synced on Windows and NixOS
  };

  programs.dconf.enable = true; # Fix missing cursors on Firefox

  virtualisation.docker.enable = true;

  users.users = {
    chloe = {
      isNormalUser = true;
      description = "Chloe";
      extraGroups = [ "networkmanager" "wheel" "docker" ];
      shell = with pkgs; zsh;
    };
  };
}