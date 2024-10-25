function node
    if command_exists "fnm" && test -z "$FNM_DIR"
        # Load fnm
        fnm --help > /dev/null
    end

    command node $argv
end
