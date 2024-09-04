#!/bin/bash

# Extracts any archive(s) (if unp isn't installed)
extract() {
    for archive in "$@"; do
        if [ -f "$archive" ]; then
            case $archive in
                *.tar.bz2) tar xvjf $archive ;;
                *.tar.gz) tar xvzf $archive ;;
                *.bz2) bunzip2 $archive ;;
                *.rar) rar x $archive ;;
                *.gz) gunzip $archive ;;
                *.tar) tar xvf $archive ;;
                *.tbz2) tar xvjf $archive ;;
                *.tgz) tar xvzf $archive ;;
                *.zip) unzip $archive ;;
                *.Z) uncompress $archive ;;
                *.7z) 7z x $archive ;;
                *) echo "don't know how to extract '$archive'..." ;;
            esac
        else
            echo "'$archive' is not a valid file!"
        fi
    done
}

# Copy and go to the directory
cpg() {
    if [ -d "$2" ]; then
        cp "$1" "$2" && cd "$2"
    else
        cp "$1" "$2"
    fi
}

# Move and go to the directory
mvg() {
    if [ -d "$2" ]; then
        mv "$1" "$2" && cd "$2"
    else
        mv "$1" "$2"
    fi
}

# Create and go to the directory
mkdirg() {
    mkdir -p "$1"
    cd "$1"
}

# Goes up a specified number of directories  (i.e. up 4)
up() {
    local d=""
    limit=$1
    for ((i = 1; i <= limit; i++)); do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d
}

install_desktop_files() {

    for desktop_file in `/usr/bin/ls $DOTDESKTOP_DIR/*.desktop`
    do
        echo /usr/share/applications/$(basename $desktop_file)
        if [[ ! -f /usr/share/applications/$(basename $desktop_file) ]]; then
            sudo ln -s $desktop_file /usr/share/applications/$(basename $desktop_file)

            echo "CREATED $(basename $desktop_file) symlink in /usr/share/applications"
        else
            echo "SKIPPING $(basename $desktop_file)... Already exists"
        fi
    done
}

bak () {
    mv $1{,.bak}
}

studio_env() {
    source ~/studio_env/bin/activate
}

activate() {
    for env in venv .venv env .env; do
        if [ -d $env ]; then
            echo "Activating virtual environment: $env"
            source $env/bin/activate
            return
        fi
    done
}

cd() {
    builtin cd "$@" && ls;
}


goto() {
    cd $(dirname $(which "$@"))
}

launch() {
    rez-env -i /mnt/servers/pipeline/rez/projects/"$1"/context.rxt
}

# function yy() {
#     local tmp="$(mktemp -t "yazi-cw.XXXXXX")"
#     yazi "$@" --cwd-file="$tmp"
#     if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
#         builtin cd -- "$cwd"
#     fi
#     rm -f -- "$tmp"
# }
#
git_global_status() {
    find . -name .git -execdir bash -c 'echo -en "\033[1;31m"repo: "\033[1;34m"; basename "`git rev-parse --show-toplevel`"; git status -s' \;
}
