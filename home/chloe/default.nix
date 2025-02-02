{
  imports = [
    ./apps
    ./catppuccin.nix
    ./docs.nix
    ./files.nix
    ./packages
  ];

  xdg.enable = true;

  # Font configuration
  fonts.fontconfig.enable = true;
}
