{ pkgs, inputs, ... }:

{
  imports = [
    ../shared
  ];

  wsl = {
    enable = true;
    defaultUser = "chloe";
    wslConf.network.hostname = "solstice";
  };

  settings.flatpak.enable = false;
  
  programs.nix-ld.dev.enable = true;

  system.stateVersion = "23.11"; # Initial NixOS version
}
