# core
alias ls="ls --color=always"
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
alias grep="grep -n --color=always"
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

# git
alias g="git"
alias ga="g a"
alias gs="g s"
alias gc="g c"
alias gb="g b"
alias gf="git fetch"
alias gco="g co"
alias glg="g lg"
alias gd="git diff"
alias gds="git diff --staged"

# other
alias python="python3"
alias za="zathura --fork"
alias xclip="xclip -selection c"

# paths
alias gowd="cd $GOPATH/src/github.com/yangkev"
alias wd="cd ~/src"
alias path="echo $PATH"

# Enable completion for git aliases
if typeset -f "__git_complete" > /dev/null; then
  __git_complete gco _git_checkout
  __git_complete gm _git_merge
  __git_complete gp _git_pull
  __git_complete glg _git_log
  __git_complete gb _git_branch
  __git_complete gd _git_diff
  __git_complete gds _git_diff
fi
