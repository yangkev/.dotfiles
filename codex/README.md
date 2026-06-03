# Codex Dotfiles

This directory contains the small amount of Codex configuration worth carrying between machines.

## Live Files

- `~/.codex/config.toml` -> `~/.dotfiles/codex/.codex/config.toml`
- `~/.codex/AGENTS.md` -> `~/.dotfiles/codex/.codex/AGENTS.md`

Keep auth, logs, caches, sessions, approval rules, and plugin runtime state in `~/.codex`; only durable config belongs in dotfiles.

If installing with `stow`, create `~/.codex` first and disable folding so stow links individual files inside that directory instead of turning the whole directory into a symlink:

```bash
mkdir -p ~/.codex
stow --no-folding codex
```

## Restore

On a new machine:

```bash
mkdir -p ~/.codex
cd ~/.dotfiles
stow --no-folding codex
codex login
codex mcp list
codex features list
```
