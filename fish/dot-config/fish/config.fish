function add_to_path_if_exists -a "to_check"
    if test -d $to_check
        set PATH "$to_check:$PATH"
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    set PAGER bat
    set EDITOR nvim

    add_to_path_if_exists "/opt/flutter/bin"
    add_to_path_if_exists "$HOME/go/bin"
    add_to_path_if_exists "$HOME/.cargo/bin"
    add_to_path_if_exists "$HOME/.local/bin"
    add_to_path_if_exists "/usr/local/opt/dotnet@6/bin"

    set PYENV_ROOT "$HOME/.pyenv"
    add_to_path_if_exists "$PYENV_ROOT/bin"

    command -v "pyenv" > /dev/null && eval "$(pyenv init -)"

    command -v "chromium" > /dev/null && set CHROME_EXECUTABLE $(which chromium)
    command -v "go" > /dev/null && set GOPATH $(go env GOPATH)

    command -v "starship" > /dev/null && starship init fish | source
    command -v "zoxide" > /dev/null && zoxide init fish | source

    if command -v "fnm" > /dev/null
        fnm env | source
        fnm completions | source
        abbr nvm fnm
        set FNM_RESOLVE_ENGINES true
    else
        if test -f /usr/share/nvm/init-nvm.sh
            echo "Activating nvm. You should consider fnm instead."
            source /usr/share/nvm/init-nvm.sh
        end
    end

    if test (uname) = "Linux" 
        if test "$XDG_SESSION_TYPE" = "wayland"
            set MOZ_ENABLE_WAYLAND 1
        end

        # command -v "scrot" > /dev/null && alias screenshot="scrot -e 'xclip -selection clipboard -t image/png -i $f && rm $f'"
    end

    if [ $(uname) = "Darwin" ]; then
         /opt/homebrew/opt/asdf/libexec/asdf.sh
        set DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
    end
end
