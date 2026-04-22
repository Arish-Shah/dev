# dev

## wsl ubuntu setup

remove unnecessary packages

```bash
sudo apt autoremove --purge vim snapd -y
```

update and upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

create xdg directories

```bash
mkdir -p "$HOME/.local/"{share,state,bin}
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Programming"
```

clone this repository

```bash
git clone https://github.com/Arish-Shah/dev "$HOME/Programming/dev"
```

run setup scripts

```bash
./run tools
./run zsh
./run nvm
./run neovim
./run clean
./dev-env
```

cleanup configs

```bash
rm -rf "$HOME/.bash"* \
    "$HOME/.motd_shown" \
    "$HOME/.profile" \
    "$HOME/.wget-hsts" \
    "$HOME/.sudo_as_admin_successful" \
    "$HOME/.landscape"
```
