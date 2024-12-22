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
  
  programs.nix-ld = {
    enable = true;
    package = inputs.nix-ld-rs.packages."${pkgs.system}".nix-ld-rs;
  };

  system.stateVersion = "23.11"; # Initial NixOS version
}
