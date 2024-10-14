#! /bin/env bash

git submodule init
git submodule update

# Ensure folders are not complete symlinks
mkdir -p ~/.config/sway/
mkdir -p ~/.ssh/
mkdir -p ~/.aws/

stow starship
stow sway
stow git
stow nvim
stow ssh
stow zsh
stow aws
