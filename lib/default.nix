{ inputs }:
let
  lib0 = inputs.nixpkgs.lib;

  myLib = lib0.makeExtensible (lib: {
    mkSystem = import ./mkSystem.nix {
      inherit lib inputs;
    };
  });
in
myLib.extend (_: _: lib0)
