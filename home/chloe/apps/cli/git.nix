{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICM6XP+CNc2CStEDe/W4LfkcRcG98obQiM2aqnydCRbX";
in
{
  home.file.".ssh/allowed_signers".text = "
    * ${signingKey}
  ";
  programs.git = {
    enable = true;
    userName = "Chloe";
    userEmail = "chloe@sapphic.moe";

    extraConfig = {
      core = lib.mkIf (osConfig ? wsl) {
        sshCommand = "ssh.exe";
      };

      user.signingkey = signingKey;
      gpg = {
        format = "ssh";
        ssh = {
          program =
            if (osConfig ? wsl) then
              "/mnt/c/Users/Chloe/AppData/Local/1Password/app/8/op-ssh-sign-wsl"
            else
              "${pkgs._1password-gui}/bin/op-ssh-sign";
          allowedSignersFile = "~/.ssh/allowed_signers";
        };
      };
      commit.gpgsign = true;
    };
  };
}
