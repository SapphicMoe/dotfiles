{ lib, inputs }:
host:
{
  specialArgs ? { },
  modules ? [ ],
  ...
}:
lib.nixosSystem {
  specialArgs = specialArgs // {
    inherit lib inputs;
  };

  modules = [
    # set hostname based on the host argument
    { networking.hostName = host; }

    inputs.home-manager.nixosModules.home-manager

    # import shared modules
    ../modules/shared

    # import by hostname
    ../hosts/${host}

    # import home manager
    ../home/default.nix
  ] ++ modules;
}
