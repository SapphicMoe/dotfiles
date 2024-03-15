{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "Chloe";
    userEmail = "solely@riseup.net";
    
    extraConfig = {
      user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJug+9rnFngnFQpY0lAO0NuVBhDCcJc5imPHazgOSTTx";
      gpg.format = "ssh";
      gpg.ssh.program = "${pkgs._1password-gui}/bin/op-ssh-sign";
      commit.gpgsign = true;
    };
  };
}