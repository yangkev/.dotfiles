# git bash completion
if [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash 
    __git_complete gch _git_checkout
fi

