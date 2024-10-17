#!/bin/bash

# zshrc config upload
ln -fs ~/Dotfiles/zshrc ~/.zshrc

# Config symlink make (nvim at the moment)
ln -fs ~/Dotfiles/config/nvim ~/.config/nvim

# tmux config symlink make
ln -fs ~/Dotfiles/tmux.conf ~/.tmux.conf

