{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    catppuccin-cursors.mochaPink
  ];

  programs.kdeconnect.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      catppuccin.enable = true;
      wayland.enable = true;
    };
  };
}