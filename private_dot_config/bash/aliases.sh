alias vim='nvim'

alias grep="/usr/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

alias ebrc='$EDITOR ~/.bashrc'

alias da='date "+%Y-%m-%d %A %T %Z"'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias less='less -R'

alias cls='clear'

alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias bk='cd "$OLDPWD"'
alias rmd='/bin/rm  --recursive --force --verbose '

alias la='ls -Alh'                # show hidden files
alias ls='ls -aFh --color=always --width=100' # add colors and file type extensions
alias lx='ls -lXBh'               # sort by extension
alias lk='ls -lSrh'               # sort by size
alias lc='ls -lcrh'               # sort by change time
alias lu='ls -lurh'               # sort by access time
alias lr='ls -lRh'                # recursive ls
alias lt='ls -ltrh'               # sort by date
alias lm='ls -alh |more'          # pipe through 'more'
alias lw='ls -xAh'                # wide listing format
alias ll='ls -Fls'                # long listing format
alias labc='ls -lap'              #alphabetical sort
alias lf="ls -l | egrep -v '^d'"  # files only
alias ldir="ls -l | egrep '^d'"   # directories only
alias ld="ldir"
alias lg='lazygit'

alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

#Custom shortcuts for activating and deactivating python venvs
alias a='activate'
alias d='deactivate'

alias ggs='git_global_status'
