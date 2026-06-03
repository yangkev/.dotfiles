# Bring in common shell settings
ZSH="$HOME/.zsh"
DOTFILES="$HOME/.dotfiles"

autoload -Uz compinit add-zsh-hook
if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi
zmodload -i zsh/complist

# General options
setopt NO_BEEP
setopt NUMERIC_GLOB_SORT
setopt EXTENDED_GLOB
unsetopt NO_MATCH
# Use Emacs bindings. This is evil but its closer to the bash defaults.
bindkey -e

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
setopt INC_APPEND_HISTORY

HISTORY_IGNORE="(ls|cd|pwd|[bf]g|exit|gs)"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZSH/.zsh_history"

# Completion
setopt ALWAYS_TO_END
setopt COMPLETE_IN_WORD

zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command "ps -u $USER -o pid,user,%cpu,cmd"
zstyle ':completion:*' rehash true

# Settings from other files
[ -f "$DOTFILES/shell/bootstrap.sh" ] && source "$DOTFILES/shell/bootstrap.sh"
[ -f "$DOTFILES/zsh/.zsh/bindings.zsh" ] && source "$DOTFILES/zsh/.zsh/bindings.zsh"
[ -f "$DOTFILES/zsh/.zsh/plugins.zsh" ] && source "$DOTFILES/zsh/.zsh/plugins.zsh"

# Source other locations of zsh and shell settings
[ -f "$HOME/.shell_local" ] && source "$HOME/.shell_local"
[ -f "$HOME/.zsh_local" ] && source "$HOME/.zsh_local"

# fzf
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# suggestions when command isn't found
[ -f "/etc/zsh_command_not_found" ] && source "/etc/zsh_command_not_found"

# fish-like autocompletion
if [ -f "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# syntax highlighting in the shell
[ -f "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Starship prompt
command -v starship >/dev/null 2>&1 && eval "$(starship init zsh)"

# Terminal theming (tinty) — applies the scheme from
# ~/.config/tinted-theming/tinty/config.toml on startup. The wrapper sources the
# generated *.sh artifacts (e.g. tinted-fzf's FZF_DEFAULT_OPTS colors) into the
# current shell so env-var-based integrations update live on `tinty apply`.
if command -v tinty >/dev/null 2>&1; then
    tinty() {
        local d="${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty"
        command tinty "$@"
        local r=$?
        for f in "$d"/*.sh; do [ -e "$f" ] && . "$f"; done
        return $r
    }
    tinty init >/dev/null 2>&1
fi

# NOTE: brew/devbox/bun/fnm PATH + shellenv setup lives in ~/.shell_local (sourced above).

# Editor — set last so it wins over devbox's shellenv (which exports EDITOR=vi)
export VISUAL=nvim
export EDITOR=nvim
