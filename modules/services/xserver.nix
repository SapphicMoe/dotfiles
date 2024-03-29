{
  services.xserver = {
    enable = true;
    desktopManager.plasma6.enable = true; # Enable KDE Plasma 6

    displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true; # Launch SDDM in Wayland
        theme = "catppuccin-sddm-corners";
        
        settings = {
          Theme.CursorTheme = "Catppuccin-Mocha-Pink-Cursors";
          General.InputMethod = ""; # Disable touchscreen keyboard
        };
      };
    };
  };
}