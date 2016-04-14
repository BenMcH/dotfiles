eval "$(rbenv init -)"
alias vpn='sudo ~/fix_vpn'
alias ll='ls -l'

#bash completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then 
  . $(brew --prefix)/etc/bash_completion
fi
