{ ... }: {
  services."06cb-009a-fingerprint-sensor" = {                                 
    enable = true;                                           
    backend = "libfprint-tod";
    # Use backend = "python-validity"; for enrolling new fingerprints.                                                
    calib-data-file = ./fp-data/calib-data.bin;                
  };
}