{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.settings.hardware.nvidia.enable = lib.mkEnableOption "Nvidia driver support";

  config = lib.mkIf config.settings.hardware.nvidia.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };

    # Load NVIDIA driver for X11 and Wayland
    services.xserver.videoDrivers = [ "nvidia" ];

    hardware.nvidia = {
      open = false;

      package =
        let
          rcu_patch = pkgs.fetchpatch {
            url = "https://github.com/gentoo/gentoo/raw/c64caf53/x11-drivers/nvidia-drivers/files/nvidia-drivers-470.223.02-gpl-pfn_valid.patch";
            hash = "sha256-eZiQQp2S/asE7MfGvfe6dA/kdCvek9SYa/FFGp24dVg=";
          };
        in
        config.boot.kernelPackages.nvidiaPackages.mkDriver {
          version = "535.154.05";
          sha256_64bit = "sha256-fpUGXKprgt6SYRDxSCemGXLrEsIA6GOinp+0eGbqqJg=";
          sha256_aarch64 = "sha256-G0/GiObf/BZMkzzET8HQjdIcvCSqB1uhsinro2HLK9k=";
          openSha256 = "sha256-wvRdHguGLxS0mR06P5Qi++pDJBCF8pJ8hr4T8O6TJIo=";
          settingsSha256 = "sha256-9wqoDEWY4I7weWW05F4igj1Gj9wjHsREFMztfEmqm10=";
          persistencedSha256 = "sha256-d0Q3Lk80JqkS1B54Mahu2yY/WocOqFFbZVBh+ToGhaE=";

          patches = [ rcu_patch ];
        };

      powerManagement = {
        enable = false;
        finegrained = true;
      };

      # Ensure the kernel doesn't tear down the card/driver prior to X startup due to the card powering down.
      nvidiaPersistenced = true;

      # the following is required for amdgpu/nvidia pairings.
      modesetting.enable = true;
      prime = {
        offload.enable = true;

        # Bus ID of AMD and NVIDIA GPUs.
        amdgpuBusId = "PCI:5:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };
}
