{ inputs, ... }:

{
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = inputs.nixos-06cb-009a-fingerprint-sensor.lib.libfprint-2-tod1-vfs0090-bingch {
        calib-data-file = ./calib-data.bin;
      };
    };
  };

  # Use this when enrolling new fingerprints.
  # services.open-fprintd.enable = true;
  # services.python-validity.enable = true;
}