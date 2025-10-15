#!/bin/bash

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

if ! [[ "$PATH" =~ "/home/linuxbrew/.linuxbrew/bin:" ]]; then
    PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
fi
