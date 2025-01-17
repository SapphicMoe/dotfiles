{ inputs, ... }:
{
  imports = [ inputs.catppuccin.nixosModules.catppuccin ];

  catppuccin = {
    accent = "pink";
    flavor = "mocha";
  };
}
