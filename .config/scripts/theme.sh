#!/bin/bash

alacritty=$HOME/.config/alacritty/alacritty.toml
nvim=$HOME/.config/nvim/init.lua

if grep -q "'light'" $nvim; then
    sed -Ei "s/light/dark/g" $alacritty
    sed -Ei "s/'light'/'dark'/g" $nvim
else
    sed -Ei "s/dark/light/g" $alacritty
    sed -Ei "s/'dark'/'light'/g" $nvim
fi
