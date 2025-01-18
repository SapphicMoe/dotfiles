{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # don't warn about dirty working directory
    warn-dirty = false;
  };

  # allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
