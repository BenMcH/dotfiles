if status is-interactive && test (uname) = "Darwin"
    . /opt/homebrew/opt/asdf/libexec/asdf.sh
    set -gx DOCKER_HOST "unix:///Users/bmchone/.colima/default/docker.sock"
end
