---
name: add-to-install
description: Add a CLI tool to this repository's install-script pattern by creating install/install-<tool>.sh. Use when the user says things like "add it to the install script", "I have this tool installed, add it", "track this package in my installer", or asks to include a new tool/package/app in the install scripts. Use ONLY for maintaining this repo's installer; not for installing packages directly.
---

# Add a tool to the install pattern

This repository is a system-restore kit with two auto-discovered areas:

- `install/` — one idempotent script per package (`install-<package>.sh`,
  each running `yay -S --noconfirm --needed <package>`), all sourced by
  `install-all.sh`.
- `stow/` — GNU Stow packages (`stow/<name>/`, each mirroring `$HOME`,
  e.g. `stow/hypr/.config/hypr/...`), deployed by the root-level
  `stow-all.sh`. It stows every package it finds there and skips packages
  whose links are already correct, so re-runs never disturb live config
  watchers (e.g. Hyprland).

When the user mentions a tool they want tracked here, add its script following
these steps. Paths below are relative to this repository's root.

## Steps

1. **Resolve the Arch package name** — not the binary name. Verify it with:
   ```bash
   pacman -Q <guessed-name>
   ```
   If the user said a binary name (e.g. `batcat`, `rg`), map it back to the
   owning package via `pacman -Qo $(command -v <binary>)`. If the package is
   NOT installed, ask the user whether to install it now; still create the
   script either way (it installs on the next `install-all.sh` run).

2. **Create the script** at `install/install-<package>.sh` with exactly this
   content (no comments, matching existing scripts):
   ```sh
   #!/bin/sh
   yay -S --noconfirm --needed <package>
   ```

3. **Make it executable and verify syntax**:
   ```bash
   chmod +x install/install-<package>.sh
   sh -n install/install-<package>.sh
   ```

4. **Report**: state that `install-all.sh` picks up the new script
   automatically (no master-list edit needed), and note nothing was committed.

## Rules

- One package per script, named after the exact package name.
- Never edit `install-all.sh` for new tools — the glob picks them up.
- New stow packages need no list edits either: create `stow/<name>/` mirroring
  `$HOME` paths (e.g. `stow/foo/.config/foo/foo.conf`) and `stow-all.sh`
  deploys it on its next run.
- Only add lines beyond the single `yay` command (e.g. enabling a service) if
  the user asks for post-install setup; keep additions idempotent.
- For multiple tools in one request, repeat steps 2–3 per tool.
- Do not git commit unless explicitly asked.
