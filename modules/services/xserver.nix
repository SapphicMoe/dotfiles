{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true; # Enable GNOME
    excludePackages = with pkgs; [ xterm ];
    # desktopManager.plasma6.enable = true; # Enable KDE Plasma 6

    displayManager = {
      gdm = {
        enable = true;
      };
      # sddm = {
        # enable = true;
        # wayland.enable = true; # Launch SDDM in Wayland
        # theme = "catppuccin-sddm-corners";
        
        # settings = {
          # Theme.CursorTheme = "Catppuccin-Mocha-Pink-Cursors";
          # General.InputMethod = ""; # Disable touchscreen keyboard
        # };
      # };
    };
  };
}
