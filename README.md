# Dotfiles

GNU Stow packages live in `stow/`, one directory per package:

- `stow/hypr` manages `~/.config/hypr/bindings.lua`.
- `stow/tmux` manages `~/.config/tmux/tmux.conf`.

From this directory, deploy them with:

```bash
stow -d stow -t ~ hypr tmux
```

## Fresh install

On a new Omarchy/Arch machine, run:

```bash
git clone <repo-url> ~/.dotfiles
~/.dotfiles/install-all.sh
```

Every tool gets its own idempotent script in `install/` (`install-stow.sh`,
`install-fzf.sh`, ...), each just running `yay -S --noconfirm --needed <tool>`.
`install-all.sh` sources them all, then deploys dotfiles via
`stow-all.sh`, which stows every package found in `stow/`
(no package list to maintain). Re-running any of it is safe.

To add a tool permanently, install it once, then:

```bash
printf '#!/bin/sh\nyay -S --noconfirm --needed <tool>\n' > install/install-<tool>.sh && chmod +x install/install-<tool>.sh
```

## Agent skill

`.agents/skills/add-to-install/` holds an agent-agnostic skill that automates
the above: ask your coding agent to "add <tool> to the install scripts" and it
will create the script following this repo's conventions.

