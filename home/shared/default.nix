{ ... }:

let
  username = "chloe";
in {
  imports = [
    ./files.nix

    ./apps/cli/bat.nix
    ./apps/cli/btop.nix
    ./apps/cli/eza.nix
    ./apps/cli/gh.nix
    ./apps/cli/git.nix
    ./apps/cli/hyfetch
    ./apps/cli/mpv.nix
    ./apps/cli/ssh.nix
    ./apps/cli/zoxide.nix
    ./apps/cli/zsh
  ];

  home = {
    username = username;
    homeDirectory = "/home/${username}";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.fontconfig.enable = true;
  
  # Home Manager state version. Do not touch.
  home.stateVersion = "23.11";
}
