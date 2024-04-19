{ pkgs, ... }:

{
  home.file = {
    # 1Password configuration
    # https://developer.1password.com/docs/ssh/agent/config
    ".config/1Password/ssh/agent.toml".text = ''
      [[ssh-keys]]
      vault = "Development"
    '';

    # Catppuccin theme for btop
    ".config/btop/themes/catppuccin_mocha.theme" = {
      source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "btop";
        rev = "ecb8562";
        sha256 = "sha256-ovVtupO5jWUw6cwA3xEzRe1juUB8ykfarMRVTglx3mk=";
      } + "/catppuccin_mocha.theme";
    };

    # Catppuccin theme for Tilix
    ".config/tilix/schemes/Catppuccin-Mocha.json" = {
      source = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "tilix";
        rev = "3fd05e03419321f2f2a6aad6da733b28be1765ef";
        hash = "sha256-SI7QxQ+WBHzeuXbTye+s8pi4tDVZOV4Aa33mRYO276k=";
      } + "/src/Catppuccin-Mocha.json";
    };
  };
}