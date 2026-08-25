#!/bin/sh
# Master install script. Run this on a fresh Omarchy/Arch machine:
#
#   git clone <your-repo-url> ~/.dotfiles
#   ~/.dotfiles/install-all.sh
#
# Runs every install/<tool>.sh, then deploys dotfiles. Safe to re-run;
# every script is idempotent.

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES_DIR

echo "==> Sudo credentials (needed once for pacman)"
sudo -v

if ! command -v yay >/dev/null 2>&1; then
    echo "==> Bootstrapping yay"
    sudo pacman -S --noconfirm --needed yay
fi

for script in "$DOTFILES_DIR"/install/install-*.sh; do
    echo "==> $(basename "$script")"
    . "$script"
done

echo "==> Deploying dotfiles with stow"
. "$DOTFILES_DIR/stow-all.sh"

echo "==> Done!"
