#! /bin/env bash

# Ensure folders are not complete symlinks
mkdir -p ~/.config/sway/
mkdir -p ~/.ssh/

stow starship
stow sway
stow git
stow nvim
stow ssh
