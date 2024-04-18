{
  security.rtkit.enable = true;  # (Optional) Enable rtkit for low-latency audio
  hardware.pulseaudio.enable = false; # Disable PulseAudio for GNOME, I guess
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
  };
}
