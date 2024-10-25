fish_config theme choose "Dracula Official"

if command_exists "pyenv"
    set -gx PYENV_ROOT "$HOME/.pyenv"
    add_to_path_if_exists "$PYENV_ROOT/bin"
    pyenv init - | source
end

command_exists "starship" && starship init fish | source
command_exists "zoxide" && zoxide init fish | source
command_exists "lsd" && abbr ls "lsd"
command_exists "fnm" && abbr nvm fnm

