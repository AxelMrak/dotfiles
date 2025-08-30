#!/usr/bin/env bash
set -euo pipefail

# bootstrap.sh
# Symlink dotfiles into $HOME using GNU Stow.
# Usage:
#   - Link all packages:   bash scripts/bootstrap.sh
#   - Link some packages:  bash scripts/bootstrap.sh nvim tmux git

log() { printf "[bootstrap] %s\n" "$*"; }
err() { printf "[bootstrap][error] %s\n" "$*" >&2; }

need_cmd() { command -v "$1" >/dev/null 2>&1; }

repo_root() {
  cd "$(dirname "$0")/.." && pwd -P
}

pick_packages() {
  local root packages
  root="$(repo_root)"
  if [ "$#" -gt 0 ]; then
    packages=("$@")
  else
    # All directories under packages/
    mapfile -t packages < <(cd "$root/packages" && find . -mindepth 1 -maxdepth 1 -type d -printf '%P\n' | sort)
  fi
  printf '%s\n' "${packages[@]}"
}

link_package() {
  local pkg="$1" root target
  root="$(repo_root)"
  target="$HOME"

  # Ensure we don't clobber real files. Stow will refuse to overwrite existing files not already symlinks.
  log "Stowing package: $pkg"
  (cd "$root/packages" && stow -v -t "$target" "$pkg")
}

main() {
  if ! need_cmd stow; then
    err "GNU Stow is required. Run scripts/install.sh first."
    exit 1
  fi

  local os pkgs
  os="$(uname -s)"

  mapfile -t pkgs < <(pick_packages "$@")
  if [ "${#pkgs[@]}" -eq 0 ]; then
    err "No packages found."
    exit 1
  fi

  # Optionally skip mac-only packages on Linux
  if [ "$os" = "Linux" ]; then
    pkgs=("${pkgs[@]/karabiner}")
    pkgs=("${pkgs[@]/iterm2}")
  fi

  for p in "${pkgs[@]}"; do
    [ -z "$p" ] && continue
    link_package "$p"
  done

  log "All done. Open a new shell session to pick up changes."
}

main "$@"

