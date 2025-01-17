{ lib, config, ... }:
{
  options.settings.bootloader.enable = lib.mkEnableOption "Enable bootloader configuration";

  config = lib.mkIf config.settings.bootloader.enable {
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
