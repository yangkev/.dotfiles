# Place for all third-party things to run in zsh

# pyenv (python version manager)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.pyenv/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# pyenv() {
#     eval "$(command pyenv init -)"
#
#     pyenv "$@"
# }

if command -v pyenv &> /dev/null; then
    # eval "$(pyenv init --path)"
    # eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"

    # Vim/Neovim don't like to play nicely with Pyright and python tooling unless PYENV_VERSION is set
    # See https://github.com/microsoft/pyright/discussions/4420
     _pyenv_version_hook() {
         local ret=$?
         if [[ -f ".python-version" ]]; then
             export PYENV_VERSION="$(cat .python-version)"
         else
             unset PYENV_VERSION
         fi
         return $ret
     };
     add-zsh-hook precmd _pyenv_version_hook
fi

# nvm (node version manager)
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
