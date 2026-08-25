#!/bin/sh
# Deploy every stow package in <repo>/stow into $HOME.
# Backs up conflicting real files, repairs stale links, then stows each
# package. Packages whose files are all already linked correctly are skipped
# untouched, so re-runs never modify the filesystem (and never trip live
# config watchers like Hyprland's).

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")" && pwd)}"
STOW_DIR="$DOTFILES_DIR/stow"

if ! command -v stow >/dev/null 2>&1; then
    echo "Error: GNU Stow is not installed. Run install-stow.sh first." >&2
    exit 1
fi

# Absolute path with symlinks resolved, tolerant of dangling links
# (readlink -f gives up on those).
resolve_to() {
    p=$1
    while [ -L "$p" ]; do
        raw=$(readlink "$p")
        case $raw in
            /*) p=$raw ;;
            *) p="$(dirname "$p")/$raw" ;;
        esac
    done
    realpath -m "$p"
}

# link_matches TARGET PACKAGE_FILE: is TARGET a symlink to PACKAGE_FILE?
link_matches() {
    [ -L "$1" ] || return 1
    [ "$(resolve_to "$1")" = "$(realpath -m "$2")" ]
}

for pkg_dir in "$STOW_DIR"/*/; do
    [ -d "$pkg_dir" ] || continue
    pkg=$(basename "$pkg_dir")
    cd "$STOW_DIR/$pkg" || exit 1

    # Skip the package entirely when every file is already stowed correctly;
    # deleting and recreating valid links makes watchers see missing files.
    status=$(find . -type f | {
        while IFS= read -r file; do
            link_matches "$HOME/${file#./}" "$STOW_DIR/$pkg/${file#./}" ||
                { echo fix; exit 0; }
        done
        echo ok
    })
    if [ "$status" = ok ]; then
        echo "--> $pkg up to date, skipping"
        continue
    fi

    echo "--> Preparing $pkg"
    # Move aside real files that would block stow from creating symlinks.
    # Stale links (dangling, or pointing anywhere other than this package)
    # are removed so stow can recreate them.
    find . -type f | while IFS= read -r file; do
        target="$HOME/${file#./}"
        link_matches "$target" "$STOW_DIR/$pkg/${file#./}" && continue
        if [ -L "$target" ]; then
            rm -f "$target"
            echo "   replaced stale link $target"
        elif [ -f "$target" ]; then
            mv "$target" "$target.bak"
            echo "   backed up $target -> $target.bak"
        fi
    done

    echo "--> Stowing $pkg"
    stow -d "$STOW_DIR" -t "$HOME" "$pkg"
done
