{ ... }:

{
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
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  # Home Manager state version. Do not touch.
  home.stateVersion = "23.11";
}
