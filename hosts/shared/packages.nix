{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    unzip
    nil
    jq
    gparted
    firefoxpwa
  ];

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    nativeMessagingHosts.packages = [ pkgs.firefoxpwa ];
  };
}
