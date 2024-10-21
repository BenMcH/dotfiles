if status is-interactive && test (uname) = "Darwin"
    fish_add_path /opt/homebrew/bin
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
    set -gx DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
end
