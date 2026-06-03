# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a dotfiles repository managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level directory is a "package" that gets symlinked to `$HOME`.

## Commands

### Installation
```bash
./install.sh           # Interactive installation of packages
./install.sh -u        # Uninstall all symlinks
stow <package>         # Install individual package (e.g., stow nvim)
stow -D <package>      # Uninstall individual package
```

### Linting
```bash
pre-commit run --all-files   # Run all pre-commit hooks
stylua --check .             # Check Lua formatting (nvim configs)
```

## Architecture

### Stow Package Structure
Each directory at root level is a stow package. The internal structure mirrors `$HOME`:
- `nvim/.config/nvim/` → `~/.config/nvim/`
- `zsh/.zshrc` → `~/.zshrc`
- `git/.gitconfig` → `~/.gitconfig`

### Key Packages
- **nvim**: Minimal Neovim config with lazy.nvim (single `init.lua` file)
  - Uses fzf-lua as primary picker (not telescope)
  - LSP: ty (Python, via uvx), pyright (fallback), ts_ls, lua_ls
  - EMFILE fixes applied (disabled file watching)
- **zsh**: Shell config with autosuggestions, syntax highlighting, starship prompt
  - `.zshrc` loads from `shell/` for shared shell functions
  - Compinit caching enabled for faster startup
- **shell**: Shared shell utilities (aliases, functions, fzf, kubernetes helpers)
- **starship**: Starship prompt config with performance optimizations
- **Brewfile**: Homebrew dependencies (`brew bundle --file=Brewfile`)

### Pre-commit Hooks
- trailing-whitespace, end-of-file-fixer, check-yaml, check-added-large-files
- forbid-tabs (excludes gdb/, bash/)
- stylua for Lua formatting
