#!/bin/bash

# Symbolic links for . files
for file in .*; do
	[[ -f $file ]] && ln -sv $HOME/dotfiles/$file $HOME/$file
done

# Symbolic links for .config/ files
[[ -d $HOME/.config ]] || mkdir $HOME/.config

ln -sv $HOME/dotfiles/.config/{nvim,scripts,alacritty} $HOME/.config/
ln -sv $HOME/dotfiles/.vim $HOME/.vim
