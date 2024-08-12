#!/bin/bash

#Check if shell is interactive
iatest=$(expr index "$-" i)

# Note: bind used instead of sticking these in .inputrc
if [[ $iatest -gt 0 ]]; then
    # Ignore case on auto-completion
    bind "set completion-ignore-case on"
    # Show auto-completion list automatically, without double tab
    bind "set show-all-if-ambiguous On"
    # Set bell style to visible
    bind "set bell-style visible"
fi
if [ ! -d ${XDG_CONFIG_HOME}/tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ${XDG_CONFIG_HOME}/tmux/plugins/tpm
    ${XDG_CONFIG_HOME}/tmux/plugins/tpm/bin/install_plugins
fi
if [ ! starship ]; then
    curl -sS https://starship.rs/install.sh | sh -s -- -b $HOME/.local/bin -y
fi
# Start tmux if not already running
#if [ ! $TMUX ]; then
#    SESSION_NAME="main"
#    ~/.tmux/plugins/tpm/bin/update_plugins all
#    tmux has-session -t $SESSION_NAME &> /dev/null
#    if [ $? != 0 ]; then
#        tmux new-session -s $SESSION_NAME -n "main" -d
#        # Automatically update plugins when starting tmux in bash
#
#    fi
#    tmux attach -t $SESSION_NAME
#fi
