{
  security.rtkit.enable = true;  # (Optional) Enable rtkit for low-latency audio

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };
    
    pulse.enable = true;
  };
}
