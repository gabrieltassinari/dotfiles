#!/bin/bash


# Create symbolic links for all files in dotfiles folder
cd ~
for f in dotfiles/.* 
do
	if [[ -f ${f} ]]; then
		filename=${f##*/}
		ln -s ${f} ${filename}
		echo "symbolic link created: ${filename}"
	fi
done

# Move all directories to proper places
mv dotfiles/.vim .
mv dotfiles/.scripts .

if [[ -d .config ]]; then
	mv dotfiles/sxhkd .config
else
	mkdir .config
	mv dotfiles/sxhkd .config
fi
