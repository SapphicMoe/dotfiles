{ pkgs, ... }:

{
  environment.gnome.excludePackages = with pkgs; [ gnome-tour ];
  hardware.pulseaudio.enable = false; # Disable PulseAudio for GNOME, I guess?
  
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    excludePackages = with pkgs; [ xterm ];

    displayManager = {
      gdm = {
        enable = true;
      };
    };
  };
}