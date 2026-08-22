# Dotfiles

GNU Stow packages:

- `hypr` manages `~/.config/hypr/bindings.lua`.
- `tmux` manages `~/.config/tmux/tmux.conf`.

From this directory, deploy them with:

```bash
stow hypr tmux
```

Package manifests live in `packages/`. Refresh them after installing or
removing software:

```bash
pacman -Qqen > ~/.dotfiles/packages/pacman-packages.txt
pacman -Qqem > ~/.dotfiles/packages/aur-packages.txt
```

On a new Omarchy/Arch system, install the official packages and then the AUR
packages (after installing `yay`):

```bash
sudo pacman -S --needed - < packages/pacman-packages.txt
yay -S --needed - < packages/aur-packages.txt
```
