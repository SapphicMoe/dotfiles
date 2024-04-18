{ pkgs, ... }:

{
  imports = [
    ./custom.nix
    ./scripts.nix
  ];
  
  home.packages = with pkgs; [
    # messengers
    telegram-desktop 
    signal-desktop

    # notes
    obsidian

    # icons
    papirus-icon-theme

    # fonts
    iosevka 
    inter 
    atkinson-hyperlegible 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) 

    # theme
    # (catppuccin-kde.override {
      # flavour = ["mocha"];
      # accents = ["pink"];
      # winDecStyles = ["classic"];
    # })

    # gnome
    gnome.gnome-tweaks
    tilix
    tracker

    # dev
    nodejs 
    corepack_latest 
    bun

    # mail
    thunderbird

    # games
    prismlauncher 
    xivlauncher 
    space-cadet-pinball
  ];
}
