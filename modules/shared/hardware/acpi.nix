# acpi_call makes tlp work for newer thinkpads
{ lib, config, ... }:
{
  options.settings.hardware.acpi.enable = lib.mkEnableOption "Enable acpi_call kernel module";

  config = lib.mkIf config.settings.hardware.acpi.enable {
    boot = {
      kernelModules = [ "acpi_call" ];
      extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
    };
  };
}
