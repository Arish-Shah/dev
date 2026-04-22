# dev

> My dotfiles and development environment setup

## WSL Ubuntu Setup

### 1. Remove Unnecessary Packages

```bash
sudo apt autoremove --purge vim snapd -y
```

### 2. Update & Upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

### 3. Create XDG Directories

```bash
mkdir -p "$HOME/.local/"{share,state,bin}
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Programming"
```

### 4. Clone This Repository

```bash
git clone https://github.com/Arish-Shah/dev "$HOME/Programming/dev"
```

### 5. Run Setup Scripts

```bash
./run tools
./run zsh
./run nvm
./run neovim
./run clean
./dev-env
```

### 6. Cleanup Configs

```bash
rm -rf "$HOME/.bash"* \
    "$HOME/.motd_shown" \
    "$HOME/.profile" \
    "$HOME/.wget-hsts" \
    "$HOME/.sudo_as_admin_successful" \
    "$HOME/.landscape"
```