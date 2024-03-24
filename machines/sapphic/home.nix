{ pkgs, ... }:


{
  imports = [ 
    ../../modules/cli-apps/bat
    ../../modules/cli-apps/btop
    ../../modules/cli-apps/eza
    ../../modules/cli-apps/gh
    ../../modules/cli-apps/git
    ../../modules/cli-apps/hyfetch
    ../../modules/cli-apps/mpv
    ../../modules/cli-apps/ssh
    ../../modules/cli-apps/yt-dlp
    ../../modules/cli-apps/zoxide
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
      # 1Password configuration
      # test: SSH_AUTH_SOCK=~/.1password/agent.sock ssh-add -l
      # https://developer.1password.com/docs/ssh/agent/config
      ".config/1Password/ssh/agent.toml".text = ''
        [[ssh-keys]]
        vault = "Development"
      '';

      # btop theme
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
      telegram-desktop signal-desktop (callPackage ../../packages/vesktop {
        vencord = pkgs.callPackage (import ../../packages/vencord/package.nix) {};
      })

      # notes
      obsidian

      # fonts
      iosevka (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })

      # dev
      nodejs corepack_latest bun

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

      # lutris
    ];

    # Environment variables
    sessionVariables = {
      # EDITOR = "emacs";
    };

    stateVersion = "23.11";
  };
}
