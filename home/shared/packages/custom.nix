{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Cider
    (callPackage ../../../packages/cider.nix { })
  ];
}