{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
  };

  # Link zsh completions
  environment.pathsToLink = [ "/share/zsh" ];
}
