{ pkgs, ... }:

{
  imports = [
    ./custom.nix # Custom packages
    ./scripts.nix # Scripts
  ];
  
  home.packages = with pkgs; [
    # messengers
    telegram-desktop signal-desktop

    # notes
    obsidian

    # fonts
    iosevka inter atkinson-hyperlegible 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) 

    # gnome
    tilix tracker

    # dev
    nodejs corepack_latest bun
    jetbrains.webstorm jetbrains.idea-ultimate jetbrains.rust-rover jetbrains.pycharm-professional

    # mail
    thunderbird

    # games
    prismlauncher xivlauncher space-cadet-pinball
  ];
}
