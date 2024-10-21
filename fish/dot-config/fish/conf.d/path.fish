add_to_path_if_exists "/opt/flutter/bin"
add_to_path_if_exists "$HOME/go/bin"
add_to_path_if_exists "$HOME/.cargo/bin"
add_to_path_if_exists "$HOME/.local/bin"
add_to_path_if_exists "/usr/local/opt/dotnet@6/bin"

set -gx PYENV_ROOT "$HOME/.pyenv"
add_to_path_if_exists "$PYENV_ROOT/bin"
