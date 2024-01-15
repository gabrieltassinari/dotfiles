#!/bin/bash

maim -s | xclip -selection clipboard -t image/png; xclip -selection clipboard -t image/png -o > ~/Pictures/screenshots/$(date +%F_%H-%M-%S).png
