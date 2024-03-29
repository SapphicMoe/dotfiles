{
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true; # Enable KDE Plasma 5

    displayManager = {
      defaultSession = "plasmawayland"; # Launch KDE Plasma 5 in Wayland
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