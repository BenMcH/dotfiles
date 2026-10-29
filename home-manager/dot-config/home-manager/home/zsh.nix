{ lib, pkgs, ... }:

{
  programs.zsh = {
    enable = true;

    initContent = ''
      if command -v fnm > /dev/null; then
        eval "$(fnm env)"
        eval "$(fnm completions --shell zsh)"
        alias nvm="fnm"
        export FNM_RESOLVE_ENGINES=true
      fi
    '' + lib.optionalString pkgs.stdenv.isLinux ''
      if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
        export MOZ_ENABLE_WAYLAND=1
      fi

      command -v "scrot" > /dev/null && alias screenshot="scrot -e 'xclip -selection clipboard -t image/png -i $f && rm $f'"
    '';

    # macOS runs an ssh-agent per login session already.
    profileExtra = lib.optionalString pkgs.stdenv.isLinux ''
      if [ -z "$SSH_AGENT_PID" ]; then
        eval "$(ssh-agent -s)"
      fi

      if [ -z "$(ssh-add -L)" ]; then
        ssh-add ~/.ssh/id_rsa
        ssh-add ~/.ssh/id_ed25519
      fi
    '';
  };
}
