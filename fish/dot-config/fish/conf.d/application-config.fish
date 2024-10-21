fish_config theme choose "Dracula Official"

if command_exists "pyenv"
    set -gx PYENV_ROOT "$HOME/.pyenv"
    add_to_path_if_exists "$PYENV_ROOT/bin"
    pyenv init - | source
end

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

