{ pkgs, ... }:

{
  home.packages = with pkgs; [ gnome.gnome-tweaks ];
  
  home.pointerCursor = {
    name = "Catppuccin-Mocha-Pink-Cursors";
    package = with pkgs; catppuccin-cursors.mochaPink;
    
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;

    iconTheme = {
      name = "Papirus Dark";
      package = with pkgs; papirus-icon-theme;
    };

    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = with pkgs; catppuccin-gtk.override {
        accents = [ "pink" ];
        size = "compact";
        tweaks = [ "rimless" ];
        variant = "mocha";
      };
    };
  };
}