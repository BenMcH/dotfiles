set -g fish_greeting
command_exists "bat" && set -gx PAGER "bat -p"
command_exists "nvim" && set -gx EDITOR nvim
command_exists "chromium" && set -gx CHROME_EXECUTABLE $(which chromium)
command_exists "go" && set -gx GOPATH $(go env GOPATH)

