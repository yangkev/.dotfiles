#!/bin/bash
#
# One-command dotfiles installer.
#   ./install.sh            Install everything (brew bundle + stow + plugins)
#   ./install.sh --no-brew  Skip `brew bundle` (fast re-run)
#   ./install.sh -u         Uninstall (remove symlinks)
#   ./install.sh -h         Help

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR" || exit 1

# Packages symlinked into $HOME via stow. Deliberately excludes:
#   shell, scripts  -> sourced / added to PATH, never symlinked
#   firefox         -> treestyletab.css applied manually in Firefox
PACKAGES=(
    bash bat claude codex ctags gdb ghostty git nvim
    ripgrep skhd starship tinty tmux yabai zsh
)

OLD_FILES="$HOME/.old_dotfiles"

usage() {
    cat <<'EOF'
Adds symlinks for all dotfile packages into $HOME and installs dependencies.

Usage: ./install.sh [option]
  (no option)     Install: brew bundle, stow packages, install tpm + tinty themes
  --no-brew       Install but skip `brew bundle`
  -u, --uninstall Remove the symlinks created by stow
  -h, --help      Show this help
EOF
}

uninstall() {
    if ! command -v stow >/dev/null 2>&1; then
        echo "stow is not installed; remove the symlinks by hand."
        exit 1
    fi
    for pkg in "${PACKAGES[@]}"; do
        if stow -D "$pkg" >/dev/null 2>&1; then
            echo "unstowed $pkg"
        fi
    done
    echo "Uninstall complete."
}

# Stow one package, backing up any conflicting existing files to ~/.old_dotfiles.
stow_pkg() {
    local pkg="$1"
    [ -d "$pkg" ] || return 0

    # Detect conflicting existing files. Handle both stow message formats:
    #   "cannot stow SRC over existing target TARGET since ..."  (stow >= 2.4)
    #   "existing target is ...: TARGET"                          (older stow)
    local conflicts
    conflicts=$(stow -n -v "$pkg" 2>&1 | sed -n \
        -e 's/.*over existing target \(.*\) since .*/\1/p' \
        -e 's/.*existing target is [^:]*: //p')
    if [ -n "$conflicts" ]; then
        while IFS= read -r f; do
            [ -z "$f" ] && continue
            echo "  backing up ~/$f -> $OLD_FILES/$f"
            mkdir -p "$OLD_FILES/$(dirname "$f")"
            mv "$HOME/$f" "$OLD_FILES/$f"
        done <<< "$conflicts"
    fi

    if stow "$pkg" 2>/dev/null; then
        echo "  stowed $pkg"
    else
        echo "  FAILED to stow $pkg" >&2
    fi
}

case "${1:-}" in
    -u|--uninstall) uninstall; exit 0 ;;
    -h|--help)      usage; exit 0 ;;
esac

# 1. Homebrew (required for everything else).
if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew not found. Install it first, then re-run this script:"
    echo '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
    exit 1
fi

# 2. Install dependencies from the Brewfile.
if [[ "${1:-}" != "--no-brew" ]]; then
    echo "==> brew bundle"
    brew bundle --file="$DOTFILES_DIR/Brewfile"
fi

# 3. Symlink packages.
if ! command -v stow >/dev/null 2>&1; then
    echo "stow missing after brew bundle; aborting." >&2
    exit 1
fi
echo "==> stow packages"
mkdir -p "$OLD_FILES"
for pkg in "${PACKAGES[@]}"; do
    stow_pkg "$pkg"
done

# 4. tmux plugin manager + plugins.
echo "==> tmux plugins (tpm)"
TPM_DIR="$HOME/.tmux/plugins/tpm"
if [ ! -d "$TPM_DIR" ]; then
    git clone https://github.com/tmux-plugins/tpm "$TPM_DIR"
fi
[ -x "$TPM_DIR/bin/install_plugins" ] && "$TPM_DIR/bin/install_plugins"

# 5. Terminal themes (tinty).
if command -v tinty >/dev/null 2>&1; then
    echo "==> tinty install"
    tinty install
fi

echo
echo "Installation complete. Restart your shell:  exec zsh"
