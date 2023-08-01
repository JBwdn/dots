#!/bin/sh

# Install dotfiles:
echo "Installing dotfiles..."

dots_dir=$(pwd)

ln -s $dots_dir/zshrc $HOME/.zshrc
ln -s $dots_dir/tmux.conf $HOME/.tmux.conf

mkdir -p $HOME/.config/nvim  # Create nvim config dir if it doesn't exist
ln -s $dots_dir/init.vim $HOME/.config/nvim/init.vim

# Symlinking scripts dir:
ln -s $dots_dir/Scripts $HOME/Scripts