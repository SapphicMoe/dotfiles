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

    # import shared modules
    ../modules/shared

    # import by hostname
    ../hosts/${host}
  ] ++ modules;
}
