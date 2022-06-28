DOTFILES=$HOME/.dotfiles

# editor defaults
export VISUAL=vi
export EDITOR=$VISUAL

# path stuff
export PATH="$PATH:$HOME/.bin"
export GOPATH="$HOME/go"
export PATH="$PATH:/usr/local/go/bin:$GOPATH/bin"
export PATH="$PATH:$HOME/.cargo/bin"

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

# Base 16 colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Gruvbox colors
VIM_BUNDLE="$HOME/.vim/bundle"
[ -n "$PS1" ] && [ -s "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh" ] && source "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh"

[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# env variables
export REVIEW_BASE="master"

# git fuzzy
export GF_PREFERRED_PAGER="delta --theme=gruvbox --highlight-removed -w __WIDTH__" ssh agent
export GF_GREP_COLOR='1;30;48;5;15'
export PATH="/Users/kyang/src/git-fuzzy/bin:$PATH"

# source common shell customizations
source "$DOTFILES/shell/aliases.sh"
source "$DOTFILES/shell/functions.sh"
source "$DOTFILES/shell/fzf.sh"
source "$DOTFILES/shell/kubernetes.sh"
source "$DOTFILES/git/git.sh"
