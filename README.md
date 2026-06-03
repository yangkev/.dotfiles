# dotfiles

[![pre-commit](https://github.com/yangkev/.dotfiles/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/yangkev/.dotfiles/actions)

### Installation

One command, on a fresh machine (requires [Homebrew](https://brew.sh)):
```
$ git clone https://github.com/yangkev/.dotfiles $HOME/.dotfiles
$ cd $HOME/.dotfiles
$ ./install.sh
```

`install.sh` does everything:
1. `brew bundle` — installs all dependencies from the [`Brewfile`](Brewfile)
2. `stow` — symlinks each package into `$HOME` (existing files are backed up to `~/.old_dotfiles`)
3. installs [tpm](https://github.com/tmux-plugins/tpm) tmux plugins and [tinty](https://github.com/tinted-theming/tinty) terminal themes

Then restart your shell (`exec zsh`).

These dotfiles are managed with [GNU Stow](https://www.gnu.org/software/stow/); each top-level directory is a package whose internal structure mirrors `$HOME`. `shell/` and `scripts/` are sourced/PATH'd rather than symlinked, so they stay out of `$HOME`.

Useful flags:
```
$ ./install.sh --no-brew   # re-stow without re-running brew bundle
$ ./install.sh -u          # remove all symlinks
$ ./install.sh -h          # help
$ stow nvim                # install a single package
$ stow -D nvim             # uninstall a single package
```

### Stuff I use

#### cli
- [fd](https://github.com/sharkdp/fd) - user friendly `find`
- [fzf](https://github.com/junegunn/fzf) - fuzzy finding anything
- [nerdfonts](https://github.com/ryanoasis/nerd-fonts)
- [ripgrep](https://github.com/BurntSushi/ripgrep) - faster grep
- [shellcheck](https://github.com/koalaman/shellcheck) - shell script static analysis
- [stow](https://www.gnu.org/software/stow/) - quickly symlink and manage dotfiles
- [tmux](https://github.com/tmux/tmux)

#### nvim
- [nvchad](https://github.com/NvChad/NvChad) - neovim config

#### zsh
- [command-not-found](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found) - suggest where to find a command
- [zsh-auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions) - fish like autosuggestion at the prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - syntax highlighting in the shell

#### tmux
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager

#### git
- [hunk](https://github.com/modem-dev/hunk) - git pager
- [delta](https://github.com/dandavison/delta) - syntax-highlighted interactive diffs

#### eye-candy
- [tinty](https://github.com/tinted-theming/tinty) - base16/tinted terminal themes
- [starship](https://github.com/starship/starship) - prompt

#### macos
- [ghostty](https://ghostty.org) - terminal
- [yabai](https://github.com/koekeishiya/yabai) - tiling window manager
- [skhd](https://github.com/koekeishiya/skhd) - hotkeys for yabai
