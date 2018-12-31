# Bring in common shell settings
DOTFILES=$HOME/.dotfiles
source "$DOTFILES/shell/bootstrap.sh"

autoload -Uz promptinit compinit
promptinit
compinit

# General options
setopt NO_BEEP
bindkey -e      # this is evil but its closer to the bash defaults
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB

# History
setopt APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY

HISTORY_IGNORE="(ls|cd|pwd|[bf]g|exit)"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Completion
setopt ALWAYS_TO_END

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Fzf bindings
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Source other locations of zsh and shell settings
[[ -f "$HOME/.shell_local" ]] && source "$HOME/.shell_local" 
[[ -f "$DOTFILES/zsh/.zsh_bindings" ]] && source "$DOTFILES/zsh/.zsh_bindings"
[[ -f "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"
