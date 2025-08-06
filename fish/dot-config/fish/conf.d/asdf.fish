
if test -f /opt/asdf-vm/asdf.fish
    source /opt/asdf-vm/asdf.fish
end

if test -f /opt/homebrew/opt/asdf/share/fish/vendor_completions.d/asdf.fish
    source /opt/homebrew/opt/asdf/share/fish/vendor_completions.d/asdf.fish
end

# ASDF configuration code
if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
