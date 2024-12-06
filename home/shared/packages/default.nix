{ pkgs, ... }:

{
  imports = [
    ./autostart.nix # Apps that will run on boot
    ./custom.nix # Custom packages
    ./scripts.nix # Scripts
  ];
  
  home.packages = with pkgs; [
    # cloud
    owncloud-client

    # messengers
    telegram-desktop

    # notes
    obsidian

    # kde
    (catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["pink"];
      winDecStyles = ["classic"];
    })

    # fonts
    iosevka inter atkinson-hyperlegible 
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) 

    # dev
    nodejs corepack_latest bun
    # jetbrains.webstorm jetbrains.idea-ultimate jetbrains.pycharm-professional

    # mail
    thunderbird

    # games
    prismlauncher

    # other
    kdePackages.akregator
  ];
}
