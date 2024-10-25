function fnm
    if command_exists "fnm"
        if test -z "$FNM_DIR"
            fnm env | source
            fnm completions | source
            set -gx FNM_RESOLVE_ENGINES true
        end
    end

    command "fnm" $argv
end
