{
  lib,
  pkgs,
  config,
  ...
}:
{
  options.settings.hardware.asus.enable = lib.mkEnableOption "Nvidia driver support";

  config = lib.mkIf config.settings.hardware.asus.enable {
    environment.systemPackages = with pkgs; [ asusctl ]; # Control panel for ASUS laptops

    services.asusd = {
      enable = true;
      enableUserService = true;
    };
  };
}
