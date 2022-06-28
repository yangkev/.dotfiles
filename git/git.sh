# git
alias g="git"
alias ga="git add"
alias gs="git status"
alias gc="git commit"
alias gb="git branch"
alias gf="git fetch"
alias gco="git checkout"
alias gcoi='git checkout $(git branch --sort=-committerdate | fzf)'
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
alias gcl="git clean -dn && git clean -df"
alias wip="git commit -m \"WIP\" --no-verify"

# https://stackoverflow.com/a/56026209 - prune local branches that have been squashed and merged
alias gprunesquashed='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | \
  while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done'
alias gprunedry='git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | \
  while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && echo "[$branch] is merged into master and can be deleted"; done'

# Enable completion for git aliases
if typeset -f "__git_complete" > /dev/null; then
  __git_complete gco _git_checkout
  __git_complete gm _git_merge
  __git_complete gp _git_pull
  __git_complete glg _git_log
  __git_complete glb _git_log
  __git_complete gb _git_branch
  __git_complete gd _git_diff
  __git_complete gds _git_diff
fi

grm() {
    # rebase the current branch on latest master
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git checkout master && git pull origin master && git checkout "$BRANCH" && git rebase master
}
