{pkgs, ...}: {
  home.file = {
    # 1Password configuration
    # https://developer.1password.com/docs/ssh/agent/config
    ".config/1Password/ssh/agent.toml".text = ''
      [[ssh-keys]]
      vault = "Development"
    '';

    # # Catppuccin theme for Konsole
    # ".local/share/konsole/catppuccin-mocha.colorscheme" = {
    #   source = pkgs.fetchFromGitHub {
    #     owner = "catppuccin";
    #     repo = "konsole";
    #     rev = "7d86b8a1e56e58f6b5649cdaac543a573ac194ca";
    #     sha256 = "sha256-EwSJMTxnaj2UlNJm1t6znnatfzgm1awIQQUF3VPfCTM=";
    #   } + "/Catppuccin-Mocha.colorscheme";
    # };

    # Catppuccin theme for Tilix
    ".config/tilix/schemes/Catppuccin-Mocha.json" = {
      source =
        pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "tilix";
          rev = "3fd05e03419321f2f2a6aad6da733b28be1765ef";
          hash = "sha256-SI7QxQ+WBHzeuXbTye+s8pi4tDVZOV4Aa33mRYO276k=";
        }
        + "/src/Catppuccin-Mocha.json";
    };
  };
}

