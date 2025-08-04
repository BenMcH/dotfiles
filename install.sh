#!/usr/bin/env bash

git submodule update --init

_stow () {
  stow --dotfiles --no-folding $1
}

# Ensure folders are not complete symlinks
mkdir -p ~/.ssh/

_stow home-manager

_stow zsh
_stow fish

command -v tmux > /dev/null && _stow tmux

command -v nvim > /dev/null && _stow nvim

if [ $(uname) = "Linux" ]; then
  if command -v xfce4-terminal > /dev/null; then
    _stow xfce4-terminal
  fi
  
  if command -v sway > /dev/null; then
    _stow sway
  fi
fi

echo "Run 'home-manager switch' to apply changes? [Y/n]"
read -r answer
if [[ $answer =~ ^[Yy]$ || -z $answer ]]; then
  home-manager switch
else
  echo "You can run 'home-manager switch' later to apply changes."
fi
