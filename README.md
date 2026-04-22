# dev

> dev setup

## wsl ubuntu setup

### 1. remove unnecessary packages

```bash
sudo apt autoremove --purge vim snapd -y
```

### 2. update & upgrade

```bash
sudo apt update && sudo apt upgrade -y
```

### 3. create xdg directories

```bash
mkdir -p "$HOME/.local/"{share,state,bin}
mkdir -p "$HOME/.config"
mkdir -p "$HOME/Programming"
```

### 4. clone repo

```bash
git clone https://github.com/Arish-Shah/dev "$HOME/Programming/dev"
```

### 5. run setup scripts

```bash
./run clean
./dev-env
```

### 6. cleanup configs

```bash
rm -rf "$HOME/.bash"* \
    "$HOME/.motd_shown" \
    "$HOME/.profile" \
    "$HOME/.wget-hsts" \
    "$HOME/.sudo_as_admin_successful" \
    "$HOME/.landscape"
```
