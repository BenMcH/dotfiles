#! /bin/env bash

git submodule init
git submodule update

# Ensure folders are not complete symlinks
mkdir -p ~/.config/sway/
mkdir -p ~/.ssh/
mkdir -p ~/.aws/

command -v starship > /dev/null && stow starship
command -v sway > /dev/null && stow sway
command -v nvim > /dev/null && stow nvim
command -v aws > /dev/null && stow aws
stow git
stow ssh
stow zsh
