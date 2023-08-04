#!/bin/bash

# Create symbolic links for all files
for f in .*
do
	if [[ -f $f ]]; then
		ln -sf $HOME/dotfiles/$f $HOME/$f
		echo "symbolic link created: $f"
	fi
done

mkdir $HOME/.vim 2>/dev/null
ln -s $HOME/dotfiles/.vim/coc-settings.json $HOME/.vim/coc-settings.json

# Move .config/ directory
if [[ -d $HOME/.config ]]; then
	mv .config/* $HOME/.config
else
	mv .config $HOME
fi
