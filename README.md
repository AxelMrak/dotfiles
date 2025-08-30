Dotfiles
========

Curated personal configuration for Neovim, tmux, shell, Git, and a few apps. Works on macOS and Linux with a simple install + bootstrap flow.

Included
--------
- Neovim: `packages/nvim/.config/nvim`
- tmux: `packages/tmux/.tmux.conf`
- Shell: `packages/shell/.zshrc`, `.zprofile`, `.bashrc`
- Git: `packages/git/.gitconfig`, `.gitignore_global`
- Ghostty (macOS): `packages/ghostty/.config/ghostty`
- Karabiner (macOS): `packages/karabiner/.config/karabiner`
- iTerm2 (macOS): `packages/iterm2/.config/iterm2`

Quick Start
----------
1) Install prerequisites and common CLI tools

   - macOS or Linux:
     - `bash scripts/install.sh`

2) Create symlinks into your home directory using GNU Stow

   - All packages:
     - `bash scripts/bootstrap.sh`
   - Specific packages only:
     - `bash scripts/bootstrap.sh nvim tmux git`

Notes
-----
- Stow layout: Each directory under `packages/` is a self‑contained “package”. Symlinks are created into `$HOME` preserving paths (e.g., `.config/nvim`).
- macOS specific:
  - Karabiner: after linking, open the Karabiner app once to grant permissions and apply complex modifications.
  - iTerm2: settings are stored under `~/.config/iterm2` here. If you prefer the default `~/Library/Preferences`, update or re‑link accordingly.
  - Ghostty: app reads configs from `~/.config/ghostty`.
- Linux specific: script auto‑detects `apt`, `dnf`, `pacman`, or `zypper`. Feel free to extend for other distros.
- Extending: add a new directory under `packages/` mirroring the target paths (e.g., `packages/starship/.config/starship.toml`) and rerun `scripts/bootstrap.sh`.

Safety
------
- The bootstrap script only creates symlinks; it will not overwrite existing real files. If a target exists, the script will skip and report it.

