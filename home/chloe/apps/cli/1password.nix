{
  pkgs,
  lib,
  osConfig,
  ...
}:

let
  inherit (pkgs) ps util-linux socat;
  grep = pkgs.gnugrep;
in
{
  home.packages = with pkgs; [
    _1password
    _1password-gui
  ];

  programs.zsh.initExtra = lib.mkIf (osConfig ? wsl) ''
    # Configure ssh forwarding
    export SSH_AUTH_SOCK=$HOME/.1password/agent.sock

    # need `ps -ww` to get non-truncated command for matching
    # use square brackets to generate a regex match for the process we want but that doesn't match the grep command running it!
    ALREADY_RUNNING=$(${ps}/bin/ps -auxww | ${grep}/bin/grep -q "[n]piperelay.exe -ei -s //./pipe/openssh-ssh-agent"; echo $?)

    if [[ $ALREADY_RUNNING != "0" ]]; then
        if [[ -S $SSH_AUTH_SOCK ]]; then
            # not expecting the socket to exist as the forwarding command isn't running (http://www.tldp.org/LDP/abs/html/fto.html)
            echo "removing previous socket..."
            rm $SSH_AUTH_SOCK
        fi

        echo "Starting SSH-Agent relay..."
        # setsid to force new session to keep running
        # set socat to listen on $SSH_AUTH_SOCK and forward to npiperelay which then forwards to openssh-ssh-agent on windows
        (${util-linux}/bin/setsid ${socat}/bin/socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
      fi
  '';
}
