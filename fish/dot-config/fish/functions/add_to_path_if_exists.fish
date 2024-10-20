function add_to_path_if_exists -a "to_check"
    if test -d $to_check
        fish_add_path $to_check
    end
end
