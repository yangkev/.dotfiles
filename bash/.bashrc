# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Bring in common shell settings
DOTFILES=$HOME/.dotfiles
source "$DOTFILES/shell/bootstrap.sh"

# Prompt
PS1='\u@\h:\w\$ '

# history
export HISTFILESIZE=10000
export HISTSIZE=10000
shopt -s histappend

# Combine multiline commands into one in history
shopt -s cmdhist

# Ignore duplicates, ls without options and builtin commands
HISTCONTROL=ignoredups
export HISTIGNORE="&:ls:[bf]g:exit"

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# enable forward search
stty -ixon

# bash completion
[[ -f "/etc/bash_completion" ]] && source "/etc/bash_completion"
[[ -f "$DOTFILES/bash/.git_aliases.sh" ]] && source "$DOTFILES/bash/.git_aliases.sh"

# fzf binding
[[ -f "$HOME/.fzf.bash" ]] && source "$HOME/.fzf.bash" && bind -x '"\C-p": vim $(fzf);'

# source other locations of bash and shell settings
[[ -f "$HOME/.shell_local" ]] && source "$HOME/.shell_local"
[[ -f "$HOME/.bash_local" ]] && source "$HOME/.bash_local"
