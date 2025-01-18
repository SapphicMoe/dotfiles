{ lib, ... }:
{
  options.settings = {
    scripts.enable = lib.mkEnableOption "Enable scripts" // {
      default = true;
    };

    gui.enable = lib.mkEnableOption "Enable GUI packages";
  };
}
