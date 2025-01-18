{ inputs, ... }:
{
  imports = [ inputs.catppuccin.homeManagerModules.catppuccin ];

  catppuccin = {
    accent = "pink";
    flavor = "mocha";
  };
}
