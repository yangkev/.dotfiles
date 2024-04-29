# Bring in common shell settings
ZSH="$HOME/.zsh"
DOTFILES="$HOME/.dotfiles"
fpath+=("$ZSH/themes")

# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
# fi

autoload -Uz promptinit compinit add-zsh-hook
promptinit
compinit
zmodload -i zsh/complist
autoload bashcompinit
bashcompinit

# Prompt
# prompt kevin

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

# Source other locations of zsh and shell settings
[ -f "$HOME/.shell_local" ] && source "$HOME/.shell_local"
[ -f "$HOME/.zsh_local" ] && source "$HOME/.zsh_local"

# fzf
[ -f "$HOME/.fzf.zsh" ] && source "$HOME/.fzf.zsh"

# suggestions when command isn't found
[ -f "/etc/zsh_command_not_found" ] && source "/etc/zsh_command_not_found"

# fish-like autocompletion
if [ -f "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    source "$ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh"
fi

# syntax highlighting in the shell
[ -f "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ] && source "$ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Starship prompt
eval "$(starship init zsh)"

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pyenv (python version manager)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

if command -v pyenv &> /dev/null; then
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # Vim/Neovim don't like to play nicely with Pyright and python tooling unless PYENV_VERSION is set
    # See https://github.com/microsoft/pyright/discussions/4420
    _pyenv_version_hook() {
        local ret=$?
        if [[ -f ".python-version" ]]; then
            export PYENV_VERSION="$(cat .python-version)"
        else
            unset PYENV_VERSION
        fi
        return $ret
    };
    add-zsh-hook precmd _pyenv_version_hook
fi

# pipx Completion
if command -v pipx &> /dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi

# zoxide (faster cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
