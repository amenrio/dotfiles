# Personal dotfiles

## Download with `chezmoi`

```bash
chezmoi -- init --aply amenrio
```

Or install both chezmoi and my dotfiles

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply amenrio
```

## Install my entire development environment

My entire development environment consists of 

* Tmux configuration and plugins
* My neovim configuration
* Starship
* Pyenv
* Lazygit
* Fzf
* poetry

Aswell as some dependencies for neovim plugins such as:
* nodejs 20.16.0

### Shorturl

```bash
curl -Lks https://shorturl.at/rgyl8 | bash
```

### Github Gist

> In case of error, try long url
```bash
curl -Lks https://gist.github.com/amenrio/b9dfd2b76821c08f3f01d0e63a75093a/raw | bash
```
