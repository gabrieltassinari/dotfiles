#!/bin/bash

# Symbolic links for . files
for f in .*; do
	if [[ $f != ".git" ]]; then
		ln -sf $HOME/dotfiles/$f $HOME/$f
		echo "symbolic link created: $f"
	fi
done

# Symbolic links for .config/ files
[[ -z $HOME/.config ]] && mkdir $HOME/.config

for d in .config/*; do ln -s $HOME/dotfiles/$d $HOME/$d; done
