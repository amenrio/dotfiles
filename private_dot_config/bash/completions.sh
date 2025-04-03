# Load bash completion scripts (if any)
if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
elif [ -f /usr/share/bash-completion/completions/git]; then
    . /usr/share/bash-completion/completions/git
fi

