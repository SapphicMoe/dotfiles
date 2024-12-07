{
  services.xserver.desktopManager.plasma6.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      theme = "catppuccin-sddm-corners";
      wayland.enable = true;

      settings = {
        Theme.CursorTheme = "Catppuccin-Mocha-Pink-Cursors";
        General.InputMethod = ""; # Disable touchscreen keyboard
      };
    };
  };
}