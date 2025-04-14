#!/bin/sh

alacritty_toml=$HOME/.config/alacritty/alacritty.toml
nvim=$HOME/.config/nvim/init.lua

if grep -q "'light'" $nvim; then
    sed -ie "s/light/dark/g" $alacritty_toml
    sed -ie "s/'light'/'dark'/g" $nvim
else
    sed -ie "s/dark/light/g" $alacritty_toml
    sed -ie "s/'dark'/'light'/g" $nvim
fi
