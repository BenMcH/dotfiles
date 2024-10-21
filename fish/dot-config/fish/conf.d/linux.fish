if status is-interactive && test (uname) = "Linux"
    if test "$XDG_SESSION_TYPE" = "wayland"
        set -gx MOZ_ENABLE_WAYLAND 1
    end

    # command_exists "scrot" && alias screenshot="scrot -e 'xclip -selection clipboard -t image/png -i $f && rm $f'"
end
