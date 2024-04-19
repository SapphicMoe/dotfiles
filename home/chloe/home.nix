{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./packages
    ./files.nix

    ../../modules/cli-apps/bat
    ../../modules/cli-apps/btop
    ../../modules/cli-apps/eza
    ../../modules/cli-apps/gh
    ../../modules/cli-apps/git
    ../../modules/cli-apps/hyfetch
    ../../modules/cli-apps/mpv
    ../../modules/cli-apps/ssh
    ../../modules/cli-apps/zoxide
    ../../modules/cli-apps/zsh

    ../../modules/apps/vscode
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.fontconfig.enable = true;

  # GTK stuff
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Pink-Dark";
      package = with pkgs;
        catppuccin-gtk.override {
          accents = ["pink"];
          size = "compact";
          tweaks = ["rimless"];
          variant = "mocha";
        };
    };
  };

  # Use Catppuccin mocha
  catppuccin.flavour = "mocha";

  # Home Manager state version. Do not touch.
  home.stateVersion = "23.11";
}
