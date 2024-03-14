{ config, ... }:

{
  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];  
  
  hardware.nvidia = {
    # this will work on the 470 stable driver as well but I had issues getting the 
    # external monitors to be recognized unless I made sure the monitors were already 
    # on during the nvidia driver's initialization. 
    # see: https://github.com/NixOS/nixpkgs/pull/141685 for the 495 beta driver.
    package = config.boot.kernelPackages.nvidiaPackages.beta;
   
    powerManagement.enable = true;
    powerManagement.finegrained = true;

    # ensure the kernel doesn't tear down the card/driver prior to X startup due to the card powering down.
    nvidiaPersistenced = true;
    
    # the following is required for amdgpu/nvidia pairings.
    modesetting.enable = true;
    prime = {
      offload.enable = true;

      # Bus ID of the AMD GPU. You can find it using lspci, either under 3D or VGA
      amdgpuBusId = "PCI:5:0:0";

      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}