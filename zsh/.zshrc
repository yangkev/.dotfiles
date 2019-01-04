# Bring in common shell settings
ZSH="$HOME/.zsh"
DOTFILES="$HOME/.dotfiles"
source "$DOTFILES/shell/bootstrap.sh"

autoload -Uz promptinit compinit
promptinit
compinit
zmodload -i zsh/complist

# General options
setopt NO_BEEP
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
HISTFILE="$ZSH/.zsh_history"

# Completion
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD
# setopt MENU_COMPLETE # fill in first completion

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command "ps -u $USER -o pid,user,%cpu,cmd"

# Fzf bindings
[[ -f "$HOME/.fzf.zsh" ]] && source "$HOME/.fzf.zsh"

# Add fish-like autocompletion
[ -f "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh" ] && source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"
#
# Source other locations of zsh and shell settings
[[ -f "$HOME/.shell_local" ]] && source "$HOME/.shell_local"
[[ -f "$DOTFILES/zsh/.zsh/bindings.zsh" ]] && source "$DOTFILES/zsh/.zsh/bindings.zsh"
[[ -f "$HOME/.zsh_local" ]] && source "$HOME/.zsh_local"

