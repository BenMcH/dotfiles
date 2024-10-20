#!/usr/bin/env bash

git submodule update --init

_stow () {
  stow --dotfiles --no-folding $1
}

# Ensure folders are not complete symlinks
mkdir -p ~/.ssh/

_stow git
_stow ssh
_stow zsh
_stow fish
command -v starship > /dev/null && _stow starship

command -v tmux > /dev/null && _stow tmux

command -v nvim > /dev/null && _stow nvim

# if command -v aws > /dev/null; then
#   mkdir -p ~/.aws/
#   _stow aws
# fi

if [ $(uname) = "Linux" ]; then
  if command -v xfce4-terminal > /dev/null; then
    _stow xfce4-terminal
  fi
  
  if command -v sway > /dev/null; then
    _stow sway
  fi
fi
