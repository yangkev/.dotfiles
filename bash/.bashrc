############################################################
# Kevin's bashrc
#
############################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path
PATH="$HOME/usr/bin:$PATH"

# Prompt
PS1='\u@\h:\w\$ '

# colorized manpages and elsewhere
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# VIM
export EDITOR=vim

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# git init
if [ -f ~/.gitconfig.sh ] ; then
    . ~/.gitconfig.sh
fi

# history
export HISTFILESIZE=20000
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

# draw UTF8 lines correctly
export NCURSES_NO_UTF8_ACS=1

# Base 16 colors
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Gruvbox colors
VIM_BUNDLE=$HOME/.vim/bundle
[ -n "$PS1" ] && [ -s $VIM_BUNDLE/gruvbox/gruvbox_256palette.sh ] && source "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh"

# Aliases
source ~/.bash_aliases

# Bash local configs
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi

# Bash functions
if [ -f ~/.bash_functions ]; then
    source ~/.bash_functions
fi

# fzf completion and ripgrep (rg)
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -x "$(command -v rg)" ] && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
bind -x '"\C-p": vim $(fzf);'
