# core
alias ls="ls --color=always -N"
alias ll="ls -alhF -N"
alias la="ls -A -N"
alias l="ls -CF -N"
alias grep="grep -n --color=always"
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias diffy="diff -y --suppress-common-lines"

# git
alias g="git"
alias ga="g a"
alias gs="g s"
alias gc="g c"
alias gb="g b"
alias gf="g f"
alias gco="g co"
alias gd="g d"
alias gds="g d --staged"
alias glg="g lg"
alias glg2="g lg2"
alias gll="g ll"
alias gr="g r"
alias gri="g r --interactive"
alias grc="g r --continue"
alias gra="g r --abort"
alias garc="git add . ; git rebase --continue"

# other
alias python="python3"
alias za="zathura --fork"
alias xclip="xclip -selection c"
alias rgh="rg --hidden"
alias rg="rg -p"

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
