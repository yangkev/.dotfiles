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

# Base 16 colors
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Gruvbox colors
VIM_BUNDLE="$HOME/.vim/bundle"
[ -n "$PS1" ] && [ -s "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh" ] && source "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh"

# ssh agent
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)"

# fzf completion and ripgrep (rg)
[ -x "$(command -v rg)" ] && export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_DEFAULT_OPTS="\
  --multi \
  --cycle \
  --height=60% \
  --preview='head -$LINES {}' \
  --preview-window=right:40%:hidden \
  --bind ?:toggle-preview"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# source common shell customizations
source "$DOTFILES/shell/aliases.sh"
source "$DOTFILES/shell/functions.sh"
