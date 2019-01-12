# dotfiles

### Installation
```
$ git clone https://github.com/yangkev/.dotfiles $HOME/.dotfiles
$ cd $HOME/.dotfiles
$ ./install.sh
```

`install.sh` will go through all top level directories and ask to install that directory's dotfiles with `stow`. 
You can also choose to install individual directories with `stow vim` (for example) instead.

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

### Useful programs

#### cli
- [stow](https://www.gnu.org/software/stow/) - quickly symlink and manage dotfiles
- [fzf](https://github.com/junegunn/fzf) - fuzzy finding anything
- [ripgrep](https://github.com/BurntSushi/ripgrep) - faster grep
- [fd](https://github.com/sharkdp/fd) - user friendly `find`

#### vim
- [Vundle](https://github.com/VundleVim/Vundle.vim) - vim plugin manager

#### zsh
- [zsh-auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions) - fish like autosuggestion at the prompt
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) - syntax highlighting in the shell
- [zsh-async](https://github.com/mafredri/zsh-async) - allow async components in the prompt
- [command-not-found](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/command-not-found) - suggest where
    to find a command

#### tmux
- [tpm](https://github.com/tmux-plugins/tpm) - tmux plugin manager

#### eye-candy
- [base16-shell](https://github.com/chriskempson/base16-shell) - terminal themes
- [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy) - better looking git diffs

