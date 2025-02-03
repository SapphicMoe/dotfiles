{
  wsl = {
    enable = true;
    defaultUser = "chloe";
  };

  settings = {
    flatpak.enable = false;

    vscode-remote.enable = true;
  };

  system.stateVersion = "23.11"; # Initial NixOS version
  nixpkgs.hostPlatform = "x86_64-linux";
}
