#!/bin/bash

# Newer alacritty versions only supports yml files.
alacritty_toml=$HOME/.config/alacritty/alacritty.toml
alacritty_yaml=$HOME/.config/alacritty/alacritty.yml

nvim=$HOME/.config/nvim/init.lua

if grep -q "'light'" $nvim; then
    sed -Ei "s/light/dark/g" $alacritty_toml $alacritty_yaml
    sed -Ei "s/'light'/'dark'/g" $nvim
else
    sed -Ei "s/dark/light/g" $alacritty_toml $alacritty_yaml
    sed -Ei "s/'dark'/'light'/g" $nvim
fi
