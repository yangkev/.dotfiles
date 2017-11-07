# git bash completion

if [ -f /etc/bash_completion.d/git ]; then
    . /etc/bash_completion.d/git
    __git_complete gch _git_checkout
elif [ -f ~/.git-completion.bash ]; then
    . ~/.git-completion.bash 
    __git_complete gch _git_checkout
fi

