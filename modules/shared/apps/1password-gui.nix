{ lib, config, ... }:
{
  config = lib.mkIf config.settings.gui.enable {
    programs = {
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ "chloe" ]; # Define the users who can authenticate via PolKit
      };
    };
  };
}
