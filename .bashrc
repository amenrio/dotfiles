#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi


# Load bash completion scripts (if any)
if [ -f /usr/share/bash-completion/bash_completion ]; then
	. /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
	. /etc/bash_completion
fi


# Load shell dotfiles, and then some:
for file in ~/bash/{path,aliases,exports,functions,extra}.sh; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file


# Check the window size after each command and, if necessary, update the values of LINES and COLUMNS
shopt -s checkwinsize

# Causes bash to append to history instead of overwriting it so if you start a new terminal, you have old session history
shopt -s histappend
PROMPT_COMMAND='history -a'



eval "$(starship init bash)"
