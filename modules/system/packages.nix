{ pkgs, ... }:

{
  # Search packages with nix search wget
  environment.systemPackages = with pkgs; [
  # vim 
  # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
    unzip
    firefox-bin
    nil
    gparted
  ];
}
