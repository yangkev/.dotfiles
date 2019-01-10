DOTFILES=$HOME/.dotfiles

# editor defaults
export VISUAL=vi
export EDITOR=$VISUAL

# path stuff
export PATH="$PATH:$HOME/bin"
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

# draw UTF8 lines correctly
export NCURSES_NO_UTF8_ACS=1

# ssh agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# source common shell customizations
source "$DOTFILES/shell/cli.sh"
source "$DOTFILES/shell/aliases.sh"
source "$DOTFILES/shell/functions.sh"
