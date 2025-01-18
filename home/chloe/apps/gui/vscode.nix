{ osConfig, ... }:
{
  programs.vscode = {
    inherit (osConfig.settings.gui) enable;
  };
}
