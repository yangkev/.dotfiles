# dotfiles

[![pre-commit](https://github.com/yangkev/.dotfiles/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/yangkev/.dotfiles/actions)

### Installation
```
$ git clone https://github.com/yangkev/.dotfiles $HOME/.dotfiles
$ cd $HOME/.dotfiles
$ ./install.sh
```

These dotfiles are managed with [GNU Stow](https://www.gnu.org/software/stow/). (See [Using GNU Stow to manage your dotfiles](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html)).

Each of the top level directories represents a package.
[`install.sh`](https://github.com/yangkev/.dotfiles/blob/master/install.sh) is a convenient installation script that will allow you to interactively install each package and will backup existing dotfiles that will be overwritten to `~/.old_dotfiles`. You can also choose to install individual packages with `stow vim` (for example) instead.

Uninstalling can be done with `./install.sh -u` or:
```
$ cd $HOME/.dotfiles
$ stow -D vim
...
```

For additional help, see:
```
$ ./install.sh -h
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
- [zsh-async](https://github.com/mafredri/zsh-async) - allow async components in the prompt
- [zsh-auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions) - fish like autosuggestion at the prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - syntax highlighting in the shell

#### tmux
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager

#### eye-candy
- [base16-shell](https://github.com/chriskempson/base16-shell) - terminal themes
- [delta](https://github.com/dandavison/delta) - better looking git diffs
- [starship](https://github.com/starship/starship) - prompt

#### macos
- [alacritty](https://github.com/alacritty/alacritty) - terminal
- [yabai](https://github.com/koekeishiya/yabai) - tiling window manager
- [skhd](https://github.com/koekeishiya/skhd) - hotkeys for yabai
