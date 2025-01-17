{ lib, config, ... }:
{
  options.settings.kde.enable = lib.mkEnableOption "Enable KDE Plasma desktop environment";

  config = lib.mkIf config.settings.kde.enable {
    programs.kdeconnect.enable = true;
    services.desktopManager.plasma6.enable = true;

    catppuccin.sddm.enable = true;

    services.displayManager = {
      sddm = {
        enable = true;
        wayland.enable = true;
      };
    };
  };
}
