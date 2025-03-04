fish_config theme choose "Dracula Official"

command_exists "starship" && starship init fish | source
command_exists "zoxide" && zoxide init fish | source
command_exists "lsd" && abbr ls "lsd"
command_exists "fnm" && abbr nvm fnm

if test -f /opt/asdf-vm/asdf.fish
    source /opt/asdf-vm/asdf.fish
end

if test -f /opt/homebrew/opt/asdf/share/fish/vendor_completions.d/asdf.fish
    source /opt/homebrew/opt/asdf/share/fish/vendor_completions.d/asdf.fish
end

function venv
    if test -n "$VIRTUAL_ENV"
        deactivate
        echo "Deactivated old venv"
    end

    if test -f ./.venv/bin/activate.fish
        . ./.venv/bin/activate.fish
    else if test -f ../.venv/bin/activate.fish
        . ../.venv/bin/activate.fish
    else
        echo "No .venv found in this folder or up a level"
        return
    end

    echo "Activated venv"
end

abbr fish-reload "source ~/.config/fish/**/*.fish"
