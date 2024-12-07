{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ asusctl ]; # Control panel for ASUS laptops

  services.asusd = {
    enable = true;
    enableUserService = true;
  };
}