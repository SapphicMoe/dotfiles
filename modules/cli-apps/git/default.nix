{ pkgs, ... }:

let
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJug+9rnFngnFQpY0lAO0NuVBhDCcJc5imPHazgOSTTx";
in {
  home.file.".ssh/allowed_signers".text = "
    * ${signingKey}
  ";
  programs.git = {
    enable = true;
    userName = "Chloe";
    userEmail = "solely@riseup.net";
    
    extraConfig = {
      user.signingkey = signingKey;
      gpg = {
        format = "ssh";
        ssh = {
          program = "${pkgs._1password-gui}/bin/op-ssh-sign";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };
      commit.gpgsign = true;
    };
  };
}