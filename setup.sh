#!/bin/bash


# Create symbolic links for all files in dotfiles folder
cd ~
for f in dotfiles/.* 
do
	if [[ -f ${f} ]]; then
		filename=${f##*/}
		ln -sf ${f} ${filename}
		echo "symbolic link created: ${filename}"
	fi
done

# Move all directories to proper places
if ! [[ -d .config ]]; then
	mkdir .config
fi

if [[ -d .config ]]; then
	ln -s dotfiles/.vim/coc-settings.json .vim/coc-settings.json
else
	mv dotfiles/.vim .
fi

mv dotfiles/sxhkd .config
mv dotfiles/.scripts .
