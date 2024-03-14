{ pkgs, ... }: 

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.75;
        blur = true;
      };

      import = [
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/catppuccin/alacritty/main/catppuccin-mocha.toml";
          hash = "sha256-nmVaYJUavF0u3P0Qj9rL+pzcI9YQOTGPyTvi+zNVPhg=";
        })
      ];
    };
  };
}