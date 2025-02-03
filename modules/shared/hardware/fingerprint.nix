{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-06cb-009a-fingerprint-sensor.nixosModules."06cb-009a-fingerprint-sensor"
  ];

  options.settings.hardware.fingerprint.enable = lib.mkEnableOption "Enable fingerprint support";

  config = lib.mkIf config.settings.hardware.fingerprint.enable {
    services."06cb-009a-fingerprint-sensor" = {
      enable = true;
      backend = "libfprint-tod";
      # Use backend = "python-validity"; for enrolling new fingerprints.
      calib-data-file = ./fp-data/calib-data.bin;
    };
  };
}
