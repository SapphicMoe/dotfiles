{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # messengers
    telegram-desktop signal-desktop (callPackage ../../packages/vesktop {
      vencord = pkgs.callPackage (import ../../packages/vencord/package.nix) {};
    })

    # notes
    obsidian

    # fonts
    iosevka open-sans atkinson-hyperlegible (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) 

    # theme
    (catppuccin-kde.override {
      flavour = ["mocha"];
      accents = ["pink"];
      winDecStyles = ["classic"];
    })

    # dev
    nodejs corepack_latest bun

    # mail
    thunderbird

    # games
    prismlauncher xivlauncher space-cadet-pinball (callPackage ../../packages/osu-lazer-bin { })

    # media
    (callPackage ../../packages/cider { })

    # Custom shell scripts
    (pkgs.writeShellScriptBin "shash" ''
      nix hash to-sri --type sha256 $(nix-prefetch-url ''$1)
    '')
    ];
}