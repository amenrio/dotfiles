#!/bin/bash

# Get the connected display names
connected_displays=$(xrandr -q | awk '/ connected/{print $1}')

if [[ $connected_displays =~ "DP-2" ]]; then
    xrandr --output DP-2 --mode 2560x1440 --rate 60

elif [[ $connected_displays =~ "DP-4" ]]; then
    xrandr --output DP-4 --mode 2560x1440
fi
