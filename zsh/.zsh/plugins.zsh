# Place for all third-party things to run in zsh

# pipx Completion
# if command -v pipx &> /dev/null; then
#     eval "$(register-python-argcomplete pipx)"
# fi

# zoxide (faster cd)
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init zsh)"
fi

###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
_gt_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
