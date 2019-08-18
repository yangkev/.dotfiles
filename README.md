# dotfiles

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
- [stow](https://www.gnu.org/software/stow/) - quickly symlink and manage dotfiles
- [fzf](https://github.com/junegunn/fzf) - fuzzy finding anything
- [ripgrep](https://github.com/BurntSushi/ripgrep) - faster grep
- [fd](https://github.com/sharkdp/fd) - user friendly `find`

#### vim
- [vim-plug](https://github.com/junegunn/vim-plug) - vim plugin manager

#### zsh
- [zsh-auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions) - fish like autosuggestion at the prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - syntax highlighting in the shell
- [zsh-async](https://github.com/mafredri/zsh-async) - allow async components in the prompt
- [command-not-found](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found) - suggest where to find a command

#### tmux
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager

#### eye-candy
- [base16-shell](https://github.com/chriskempson/base16-shell) - terminal themes
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) - better looking git diffs
