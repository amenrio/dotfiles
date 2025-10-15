#!/bin/bash

function trimString()
{
    local -r string="${1}"

    sed -e 's/^ *//g' -e 's/ *$//g' <<< "${string}"
}

function isEmptyString()
{
    local -r string="${1}"

    if [[ "$(trimString "${string}")" = '' ]]
    then
        echo 'true'
    else
        echo 'false'
    fi
}

function info()
{
    local -r message="${1}"

    echo -e "\033[1;36m${message}\033[0m" 2>&1
}

function getLastAptGetUpdate()
{
    local aptDate="$(stat -c %Y '/var/cache/apt')"
    local nowDate="$(date +'%s')"

    echo $((nowDate - aptDate))
}

function runAptGetUpdate()
{
    local updateInterval="${1}"

    local lastAptGetUpdate="$(getLastAptGetUpdate)"

    if [[ "$(isEmptyString "${updateInterval}")" = 'true' ]]
    then
        # Default To 24 hours
        updateInterval="$((24 * 60 * 60))"
    fi

    if [[ "${lastAptGetUpdate}" -gt "${updateInterval}" ]]
    then
        info "apt-get update"
        sudo apt-get update -m && sudo apt-get upgrade -y
		sudo apt-get autoremove -y
    else
        local lastUpdate="$(date -u -d @"${lastAptGetUpdate}" +'%-Hh %-Mm %-Ss')"
	local interval="$(date -u -d @"${updateInterval}" +'%-Hh %-Mm %-Ss')"

	info "\nSkip apt-get update because its last run was '${lastUpdate}' ago. (Interval set to '${interval}')"
    fi
}

runAptGetUpdate 360

if ! [ -d "$HOME/.local/bin" ]; then
    mkdir -p "$HOME"/.local/bin
fi

if ! [ -x "$(command -v gcc)" ]; then
    info "Installing gcc ..."
    sudo apt-get install gcc -y
else
    info "Skipping gcc ..."
fi

if ! [ -f "$HOME/.local/bin/fd" ]; then
    info "Installing fd-find ..."
    sudo apt install fd-find -y
    ln -s $(which fdfind) "$HOME/.local/bin/fd"
else
    info "Skipping fd-find ..."
fi

if ! [ -x "$(command -v rg)" ]; then
    info "Installing rg ..."
    sudo apt install ripgrep -y
else
    info "Skipping ripgrep ..."
fi

# Install Starship
if ! [ -x "$(command -v starship)" ]; then
    info "Installing starship ..."
    curl -sS https://starship.rs/install.sh | sh -s -- -b "$HOME/.local/bin" -y
    . "$HOME/.bashrc"
else
    info "Skipping starship ..."
fi

# Install chezmoi
if ! [ -x "$(command -v chezmoi)" ]; then
    info "Installing chezmoi ..."
    sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply amenrio
    . "$HOME/.bashrc"
else
    info "Skipping chezmoi ..."
fi

# Install Uv and multiple python versions
if ! [ -x "$(command -v uv)" ]; then
    info "Installing uv ..."
    curl -LsSf https://astral.sh/uv/install.sh | sh
	. "$HOME/.bashrc"
    info "Installing python versions ..."
    $HOME/.local/bin/uv python install 3.14 3.13 3.12 3.11 3.10 3.9
    ln -s $(which python3.13) $HOME/.local/bin/python 
    ln -s $(which python3.13) $HOME/.local/bin/python3
else
    info "Skipping Uv ..."
fi

# Install Rust and Cargo
if ! [ -x "$(command -v cargo)" ]; then
    . "$HOME/.bashrc"
    info "Installing rust & cargo ..."
    curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
else
    info "Skipping Rust & Cargo ..."
fi

# Install bob
if ! [ -x "$(command -v bob)" ]; then
    . "$HOME/.bashrc"
    info "Installing bob ..."
    cargo install --git https://github.com/MordechaiHadad/bob.git
else
    info "Skipping bob ..."
fi

# Install nvim
if ! [ -x "$(command -v nvim)" ]; then
    . "$HOME/.bashrc"
    info "Installing nvim with bob ..."
    if ! [ -f "$HOME/.bash_profile" ]; then
	printf "if [ -n \"$BASH\" ] && [ -r ~/.bashrc ]; then\n    . ~/.bashrc\nfi" > ~/.bash_profile
    fi
    bob install nightly
    ln -s "$HOME/.local/share/bob/nvim-bin/nvim" "$HOME/.local/bin/nvim"
    bob use nightly
else
    info "Skipping nvim ..."
fi

# Install nvm
if ! [ -x "$(command -v node)" ]; then
    info "Installing nvm ..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    . "$HOME/.bashrc"
    info "Installing nodejs versions ..."
    nvm install 16
    nvm install node
    info "Use latest version of node ..."
    nvm use node
else
    info "Skipping nvm ..."
fi

# Install taskfile
if ! [ -x "$(command -v task)" ]; then
    info "Installing taskfile ..."
    sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b "$HOME/.local/bin"
    . "$HOME/.bashrc"
else
    info "Skipping taskfile ..."
fi

if ! [ -x "$(command -v brew)" ]; then
    info "Installing homebrew ..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
    info "Skipping homebrew ..."
fi

if ! [ -x "$(command -v fzf)" ]; then
    info "Installing fzf ..."
	brew install fzf
	. "$HOME/.bashrc"
else
    info "Skipping fzf ..."
fi

if ! [ -x "$(command -v lazygit)" ]; then
    info "Installing lazygit ..."
	brew install lazygit
	. "$HOME/.bashrc"
else
    info "Skipping lazygit ..."
fi
