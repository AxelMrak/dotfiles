#!/usr/bin/env bash
set -euo pipefail

# install.sh
# Cross-platform installer for common CLI tools used by these dotfiles.
# - macOS: Homebrew
# - Linux: apt, dnf, pacman, or zypper

need_cmd() { command -v "$1" >/dev/null 2>&1; }
log() { printf "[install] %s\n" "$*"; }
err() { printf "[install][error] %s\n" "$*" >&2; }

PACKAGES_COMMON=(git neovim tmux ripgrep fd fzf stow)
# Nice-to-haves (optional): lazygit, starship
PACKAGES_EXTRA=(lazygit starship)

install_macos() {
  if ! need_cmd brew; then
    log "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$([ -x /opt/homebrew/bin/brew ] && echo 'eval \"$(/opt/homebrew/bin/brew shellenv)\"' || echo 'eval \"$(/usr/local/bin/brew shellenv)\"')"
  fi
  log "Installing packages with Homebrew"
  brew update
  brew install "${PACKAGES_COMMON[@]}" || true
  brew install "${PACKAGES_EXTRA[@]}" || true

  # Optionally set up fzf keybindings/completion
  if [ -x "$(brew --prefix)/opt/fzf/install" ]; then
    "$(brew --prefix)/opt/fzf/install" --no-bash --no-fish --key-bindings --completion || true
  fi
}

install_linux_with() {
  local pm="$1"; shift
  case "$pm" in
    apt)
      sudo apt update
      sudo apt install -y "${PACKAGES_COMMON[@]}" "${PACKAGES_EXTRA[@]}" ;;
    dnf)
      sudo dnf install -y "${PACKAGES_COMMON[@]}" "${PACKAGES_EXTRA[@]}" ;;
    pacman)
      sudo pacman -Sy --noconfirm "${PACKAGES_COMMON[@]}" "${PACKAGES_EXTRA[@]}" ;;
    zypper)
      sudo zypper refresh
      sudo zypper install -y "${PACKAGES_COMMON[@]}" "${PACKAGES_EXTRA[@]}" ;;
    *) err "Unsupported package manager: $pm"; return 1;;
  esac
}

install_linux() {
  if need_cmd apt; then install_linux_with apt; return 0; fi
  if need_cmd dnf; then install_linux_with dnf; return 0; fi
  if need_cmd pacman; then install_linux_with pacman; return 0; fi
  if need_cmd zypper; then install_linux_with zypper; return 0; fi
  err "No supported package manager found. Please install: ${PACKAGES_COMMON[*]}"
  return 1
}

main() {
  local os
  os="$(uname -s)"
  log "Detected OS: $os"
  case "$os" in
    Darwin) install_macos ;;
    Linux) install_linux ;;
    *) err "Unsupported OS: $os"; exit 1;;
  esac

  log "Done. Next: run scripts/bootstrap.sh to create symlinks."
}

main "$@"

