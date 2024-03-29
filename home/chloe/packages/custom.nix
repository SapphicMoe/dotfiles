{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Vesktop with patched Vencord
    (callPackage ../../../packages/vesktop {
      vencord = pkgs.callPackage (import ../../../packages/vencord/package.nix) {};
    })

    # osu
    (callPackage ../../../packages/osu-lazer-bin { })

    # Cider
    (callPackage ../../../packages/cider { })
  ];
}