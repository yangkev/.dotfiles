DOTFILES=$HOME/.dotfiles

# editor defaults
export VISUAL=nvim
export EDITOR=$VISUAL

# colorized manpages and elsewhere
export LESS=-R
export LESS_TERMCAP_mb=$(printf "\e[1;31m")     # begin bold
export LESS_TERMCAP_md=$(printf "\e[1;36m")     # begin blink
export LESS_TERMCAP_me=$(printf "\e[0m")        # reset bold/blink
export LESS_TERMCAP_so=$(printf "\e[01;44;33m") # begin reverse video
export LESS_TERMCAP_se=$(printf "\e[0m")        # reset reverse video
export LESS_TERMCAP_us=$(printf "\e[1;32m")     # begin underline
export LESS_TERMCAP_ue=$(printf "\e[0m")        # reset underline

# Set executables explicitly to green in 'ls' output
export LSCOLORS="exfxcxdxcxegedabagacad"

# draw UTF8 lines correctly
export NCURSES_NO_UTF8_ACS=1

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# env variables
export REVIEW_BASE="master"

# git fuzzy
export GF_PREFERRED_PAGER="delta --theme=gruvbox --highlight-removed -w __WIDTH__" ssh agent
export GF_GREP_COLOR='1;30;48;5;15'

# dotfiles scripts on PATH
export PATH="$DOTFILES/scripts:$PATH"

# source common shell customizations
source "$DOTFILES/shell/aliases.sh"
source "$DOTFILES/shell/functions.sh"
source "$DOTFILES/shell/fzf.sh"
# source "$DOTFILES/shell/kubernetes.sh"
source "$DOTFILES/shell/git.sh"

# Always keep ssh-agent running
# if [ ! -S ~/.ssh/ssh_auth_sock ]; then
#     eval `ssh-agent`
#     ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
# fi
# export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
# ssh-add -l > /dev/null || ssh-add
