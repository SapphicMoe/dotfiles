{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "shash" ''
      nix hash to-sri --type sha256 $(nix-prefetch-url ''$1)
    '')
  ];
}