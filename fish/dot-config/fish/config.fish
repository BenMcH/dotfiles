if status is-interactive
    set -g fish_greeting
    fish_config theme choose "Dracula Official"
    command_exists "bat" && set -gx PAGER "bat -p"
    command_exists "nvim" && set -gx EDITOR nvim

    add_to_path_if_exists "/opt/flutter/bin"
    add_to_path_if_exists "$HOME/go/bin"
    add_to_path_if_exists "$HOME/.cargo/bin"
    add_to_path_if_exists "$HOME/.local/bin"
    add_to_path_if_exists "/usr/local/opt/dotnet@6/bin"

    set -gx PYENV_ROOT "$HOME/.pyenv"
    add_to_path_if_exists "$PYENV_ROOT/bin"

    command_exists "pyenv" && eval "$(pyenv init -)"

    command_exists "chromium" && set -gx CHROME_EXECUTABLE $(which chromium)
    command_exists "go" && set -gx GOPATH $(go env GOPATH)

    command_exists "starship" && starship init fish | source
    command_exists "zoxide" && zoxide init fish | source
    command_exists "lsd" && abbr ls "lsd"

    if command_exists "fnm"
        fnm env | source
        fnm completions | source
        abbr nvm fnm
        set -gx FNM_RESOLVE_ENGINES true
    else
        if test -f /usr/share/nvm/init-nvm.sh
            echo "Activating nvm. You should consider fnm instead."
            source /usr/share/nvm/init-nvm.sh
        end
    end

    if test (uname) = "Linux" 
        if test "$XDG_SESSION_TYPE" = "wayland"
            set -gx MOZ_ENABLE_WAYLAND 1
        end

        # command_exists "scrot" && alias screenshot="scrot -e 'xclip -selection clipboard -t image/png -i $f && rm $f'"
    end

    if test (uname) = "Darwin"
        . /opt/homebrew/opt/asdf/libexec/asdf.sh
        set -gx DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
    end
end
