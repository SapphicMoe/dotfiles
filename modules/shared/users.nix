{ pkgs, ... }:
{
  users.users = {
    chloe = {
      isNormalUser = true;
      description = "Chloe";
      extraGroups = [
        "networkmanager"
        "wheel"
        "docker"
        "pipewire" # this give us access to the rt limits
      ];
      shell = pkgs.zsh;
    };
  };
}
