{
  config,
  lib,
  ...
}:

{
  imports = [
    ./apps
    ./hardware
    ./bootloader.nix
    ./catppuccin.nix
    ./kde.nix
    ./nix.nix
    ./options.nix
    ./packages.nix
    ./users.nix
    ./zsh.nix
  ];

  options.settings = {
    docker.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    flatpak.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
    tailscale.enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
    };
  };

  config = {
    time = {
      timeZone = "Asia/Almaty";
      hardwareClockInLocalTime = true; # Keep time synced on Windows and NixOS
    };

    services = {
      flatpak.enable = config.settings.flatpak.enable;
      tailscale.enable = config.settings.tailscale.enable;
    };

    programs.dconf.enable = true; # Fix missing cursors on Firefox

    virtualisation.docker.enable = config.settings.docker.enable;

    security.polkit.enable = true; # Enable PolKit for system authentication in 1Password
  };
}
