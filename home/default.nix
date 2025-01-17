{
  inputs,
  ...
}:
{
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;

    extraSpecialArgs = { inherit inputs; };

    sharedModules = [
      {
        # reload system units when changing configs
        systemd.user.startServices = "sd-switch";

        # let HM manage itself when in standalone mode
        programs.home-manager.enable = true;
      }
    ];

    users.chloe = ./chloe;
  };
}
