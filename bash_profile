eval "$(rbenv init -)"
alias vpn='sudo ~/fix_vpn'
alias ll='ls -l'

# Git branch in prompt.

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\w\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
export PATH="/usr/local/mysql/bin:$PATH"

alias b='bundle exec'
