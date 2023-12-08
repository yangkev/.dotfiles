# core
alias ls="ls --color=always"
alias ll="ls -alhF"
alias la="ls -A"
alias l="ls -CF"
# alias grep="grep -n --color=always"
# alias grep='grep --color=always'
alias fgrep='fgrep --color=always'
alias egrep='egrep --color=always'
alias diffy="diff -y --suppress-common-lines"
alias vi="vim"
alias vim="nvim"

# other
alias za="zathura --fork"
alias xclip="xclip -selection c"
alias rgh="rg --hidden"
alias rg="rg -p"
alias dot="cd ~/.dotfiles"

# paths
alias path="echo $PATH"

# pre-commit (pcc: pre-commit changed)
alias pcc="pre-commit run --from-ref master --to-ref HEAD"
