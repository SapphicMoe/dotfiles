{ config, lib, pkgs, ... }:

{
  imports = [
    ./packages.nix

    ../../modules/apps/cli/zsh.nix
  ];
  
  options.settings = {
    docker.enable = lib.mkOption { type = lib.types.bool; default = true; };
    flatpak.enable = lib.mkOption { type = lib.types.bool; default = true; };
    tailscale.enable = lib.mkOption { type = lib.types.bool; default = true; };
  };
  
  config = {
    environment.pathsToLink = [ "/share/zsh" ]; # Link zsh completions

    # Nix options
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    time = {
      timeZone = "Asia/Almaty";
      hardwareClockInLocalTime = true; # Keep time synced on Windows and NixOS
    };

    catppuccin = {
      accent = "pink";
      flavor = "mocha";
    };

    services = {
      flatpak.enable = config.settings.flatpak.enable;
      tailscale.enable = config.settings.tailscale.enable;
    };

    programs.dconf.enable = true; # Fix missing cursors on Firefox

    virtualisation.docker.enable = config.settings.docker.enable;

    security.polkit.enable = true; # Enable PolKit for system authentication in 1Password

    users.users = {
      chloe = {
        isNormalUser = true;
        description = "Chloe";
        extraGroups = [ "networkmanager" "wheel" "docker" ];
        shell = with pkgs; zsh;
      };
    };
  };
}