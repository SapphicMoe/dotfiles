{ ... }: 

{
  programs.bat = {
    enable = true;
    catppuccin.enable = true;
    
    config = {
      pager = "less -FR";
    };
  };
}