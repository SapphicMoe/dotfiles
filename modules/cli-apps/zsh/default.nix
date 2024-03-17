{ pkgs, ... }:

{
  imports = [
    ../../common/zsh.nix
  ];

  programs.zsh = {      
    # zsh configuration file
    dotDir = ".config/zsh";

    initExtra = ''
      eval "$(zoxide init zsh)"  
    '';

    shellAliases = {
      cat = "bat";
      cd = "z";
      ls = "eza";
    };

    oh-my-zsh.enable = true;

    plugins = [
      {
        name = "powerlevel10k-config";
        src = ./p10k;
        file = "p10k.zsh";
      }
      {
        name = "zsh-powerlevel10k";
        src = "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/";
        file = "powerlevel10k.zsh-theme";
      }
    ];
  };
}