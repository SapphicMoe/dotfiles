{ pkgs, ... }:


{
  imports = [ 
    ../../modules/cli-apps/bat
    ../../modules/cli-apps/btop
    ../../modules/cli-apps/eza
    ../../modules/cli-apps/git
    ../../modules/cli-apps/gh
    ../../modules/cli-apps/hyfetch
    ../../modules/cli-apps/mpv
    ../../modules/cli-apps/zsh
    
    ../../modules/apps/alacritty
    ../../modules/apps/vscode

  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  # Home Manager configuration
  home = {
    username = "chloe";
    homeDirectory = "/home/chloe";

    file = {
      ".config/btop/themes/catppuccin_mocha.theme" = {
        source = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "btop";
          rev = "ecb8562";
          sha256 = "sha256-ovVtupO5jWUw6cwA3xEzRe1juUB8ykfarMRVTglx3mk=";
        } + "/catppuccin_mocha.theme";
      };
    };

    packages = with pkgs; [
      # messengers
      telegram-desktop signal-desktop discord

      # fonts
      iosevka (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # mail
      thunderbird

      # games
      prismlauncher xivlauncher space-cadet-pinball (callPackage ../../packages/osu-lazer-bin { })

      # media
      (callPackage ../../packages/cider { })

      # asus
      asusctl

      # Custom shell scripts
      (pkgs.writeShellScriptBin "shash" ''
        nix hash to-sri --type sha256 $(nix-prefetch-url ''$1)
      '')

      # obsidian
      # lutris
    ];

    # Environment variables
    sessionVariables = {
      # EDITOR = "emacs";
    };

    stateVersion = "23.11";
  };
}
