{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Vesktop with patched Vencord
    (callPackage ../../../packages/vesktop {
      vencord = pkgs.callPackage (import ../../../packages/vencord.nix) {};
    })

    # Cider
    (callPackage ../../../packages/cider.nix { })
  ];
}