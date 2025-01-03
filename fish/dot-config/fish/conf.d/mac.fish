if status is-interactive && test (uname) = "Darwin"
    source /opt/homebrew/opt/asdf/libexec/asdf.fish
    set -gx DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
end
