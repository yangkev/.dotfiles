############################################################
# Kevin's bashrc
#
############################################################

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# path
PATH="$HOME/usr/bin:$PATH"

# colorized manpages and elsewhere
export LESS=-R
export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
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

source ~/.bash_aliases
if [ -f ~/.bash_local ]; then
    source ~/.bash_local
fi
