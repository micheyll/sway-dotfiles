#!/bin/bash

# Get a list of all connected outputs
outputs=$(swaymsg -t get_outputs | jq -r '.[].name')

# Set a random wallpaper for each output
for output in $outputs
do
    wallpaper=$(find ~/Pictures/Wallpapers/. -type f | shuf -n1)
    swaymsg output $output bg "$wallpaper" fill
done
