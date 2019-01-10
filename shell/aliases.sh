# core
alias ls="ls --color=always -N"
alias ll="ls -alhF -N"
alias la="ls -A -N"
alias l="ls -CF -N"
alias grep="grep -n --color=always"
alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'

# git
alias g="git"
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gb="git branch"
alias gf="git fetch"
alias gco="git checkout"
alias gd="git diff"
alias gds="git diff --staged"
alias glg="git log --graph --abbrev-commit --decorate --pretty=format:'%C(bold yellow)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold cyan)%d%C(reset)'"
alias glg2="git log --graph --abbrev-commit --decorate --pretty=format:'%C(bold yellow)%h%C(reset) - %C(bold blue)%aD%C(reset) %C(bold green)(%cr)%C(reset) %C(bold red)[%an]%C(reset)%C(bold cyan)%d%C(reset)%n''          %C(white)%s%C(reset)%n' --all"
alias gll="git log --pretty=format:'%C(bold cyan)%d%C(reset)%n''%C(bold yellow)%h%C(reset) - %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(bold red)[%cn]%C(reset)' --numstat"

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
