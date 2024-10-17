#! /bin/env zsh

git submodule init
git submodule update

# Ensure folders are not complete symlinks
mkdir -p ~/.ssh/

stow git
stow ssh
stow zsh

command -v tmux > /dev/null && stow tmux
command -v starship > /dev/null && stow --dotfiles starship

command -v nvim > /dev/null && stow nvim

if command -v aws > /dev/null; then
  mkdir -p ~/.aws/
  stow --dotfiles aws
fi

if [ $(uname) = "Linux" ]; then
  if command -v xfce4-terminal > /dev/null; then
    mkdir -p ~/.local/share/xfce4/terminal/colorschemes
    stow --dotfiles xfce4-terminal
  fi
  
  if command -v sway > /dev/null; then
    mkdir -p ~/.config/sway/
    stow --dotfiles sway
  fi
fi
