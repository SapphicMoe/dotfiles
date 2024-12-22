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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    
    stateVersion = "23.11"; # Home Manager state version. Do not touch.
  };

  catppuccin = {
    accent = "pink";
    flavor = "mocha";
  };
  
  xdg.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Font configuration
  fonts.fontconfig.enable = true;
}
