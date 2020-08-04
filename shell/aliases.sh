# core
alias ls="ls --color=always -N"
alias ll="ls -alhF -N"
alias la="ls -A -N"
alias l="ls -CF -N"
# alias grep="grep -n --color=always"
# alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias diffy="diff -y --suppress-common-lines"
alias vi="vim"
alias vim="nvim"

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
alias glg="git lg"
alias gl="git l"
alias glg2="git lg2"
alias gl2="git l2"
alias gll="git ll"
alias gr="git rebase"
alias gri="git rebase --interactive"
alias grc="git rebase --continue"
alias gra="git rebase --abort"
alias garc="git add . ; git rebase --continue"

# https://stackoverflow.com/a/56026209 - prune local branches that have been squashed and merged
alias gprunesquashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | \
  while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias gprunedry='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | \
  while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && echo "[$branch] is merged into master and can be deleted"; done'

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
