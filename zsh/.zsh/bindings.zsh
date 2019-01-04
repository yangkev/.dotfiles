# Use Emacs bindings. This is evil but its closer to the bash defaults.
bindkey -e

autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

# Only hit [Enter] once when picking from auto-complete menu
bindkey -M menuselect '^M' .accept-line
#
# [Ctrl-o] to accept a completion and continue completing (helpful for completing long paths)
bindkey -M menuselect '^o' .accept-and-infer-next-history

# [Shift-Tab] - move through the completion menu backwards
if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Ctrl-P] to fzf and open file in vim
bindkey -s "^P" 'vim $(fzf)\n'
