{ pkgs, ... }:

{
  programs.hyfetch = {
    enable = true;

    settings = {
      preset = "transgender";
      mode = "rgb";
      light_dark = "dark";
      lightness = 0.65;

      color_align = {
        mode = "horizontal";
        custom_colors = [];
        fore_back = null;
      };

      backend = "neofetch";
      args = null;
      distro = null;
      pride_month_shown = [];
      pride_month_disable = false;
    };
  };

  xdg.configFile."neofetch/config.conf".source = ./neofetch.conf;

  home.packages = with pkgs; [pciutils]; # Required to display GPU
}