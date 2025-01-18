{ pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.networkmanager.enable = true;

  settings = {
    kde.enable = true;

    scripts.enable = true;
    gui.enable = true;

    bootloader.enable = true;

    hardware = {
      audio.enable = true;
      acpi.enable = true;
      fingerprint.enable = true;
    };
  };

  boot = {
    blacklistedKernelModules = [ "i915" ];
    kernelParams = [
      "snd_hda_intel.power_save=1"
      "i915.enable_psr=0"
      "bbswitch.load_state=0"
      "bbswitch.unload_state=1"
    ];
  };

  hardware = {
    graphics.enable = true;
    graphics.extraPackages = with pkgs; [ intel-media-driver ];
    bluetooth.enable = true;
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
    trackpoint = {
      enable = true;
      emulateWheel = true;
    };
  };

  services = {
    fstrim.enable = true;
    fwupd.enable = true;
    power-profiles-daemon.enable = false;
    tlp.enable = true;
    throttled.enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  system.stateVersion = "23.11"; # Initial NixOS version
}
