{
  security.polkit.enable = true; # Enable PolKit for system authentication in 1Password

  programs = {
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ "chloe" ]; # Define the users who can authenticate via PolKit
    };
  };
}