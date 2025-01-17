{
  imports = [
    ./files.nix
    ./catppuccin.nix
    ./apps
  ];

  xdg.enable = true;

  # Font configuration
  fonts.fontconfig.enable = true;
}
