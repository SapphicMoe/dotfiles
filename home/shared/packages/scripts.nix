{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellScriptBin "shash" ''
      nix hash to-sri --type sha256 $(nix-prefetch-url ''$1)
    '')
    
    (writeShellScriptBin "nix-rb" ''
      sudo nixos-rebuild switch --flake .#$1
    '')
    (writeShellScriptBin "hm-rb" ''
      nix run home-manager -- switch --flake .#$1
    '')

    (writeShellScriptBin "create-venv" ''
      nix-shell -p python3 --command "python -m venv .venv --copies"
    '')
  ];
}