# fzf customizations
[ "$(command -v fzf >/dev/null 2>&1)" ] && return

KEYBINDINGS="\
?:toggle-preview,\
ctrl-d:half-page-down,\
ctrl-u:half-page-up,\
ctrl-f:page-down,\
ctrl-b:page-up,\
ctrl-a:select-all,\
alt-j:preview-down,\
alt-k:preview-up,\
alt-f:preview-page-down,\
alt-b:preview-page-up"

export FZF_DEFAULT_OPTS="\
  --multi \
  --cycle \
  --height=60% \
  --preview='bat --color=always --style=numbers --line-range=:500 {}' \
  --preview-window=right:50%:hidden \
  --bind=$KEYBINDINGS \
  --history=$HOME/.fzf_history"

if [ ! "$(command -v rg >/dev/null 2>&1)" ]; then
  export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
  export FZF_DEFAULT_COMMAND='\rg --color=auto --files --no-ignore --hidden --follow 2> /dev/null'
fi

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

if [ ! "$(command -v fd >/dev/null 2>&1)" ]; then
  export FZF_ALT_C_COMMAND="fd --hidden --type d --color=never --exclude '{.git,node_modules}/*'"
fi

if [ ! "$(command -v tree >/dev/null 2>&1)" ]; then
  export FZF_ALT_C_OPTS="\
    --cycle \
    --height=80% \
    --preview=\"tree -a -C -L 2 -I '.git|node_modules' --noreport {}\" \
    --preview-window=right:50%:hidden \
    --bind ?:toggle-preview"
fi

# functions

FZF_GIT_LOG_CMD=('git' 'l')
# fzf_git_log allows using fzf as a git log browser with the ability to preview commit diffs (with git show).
# Inspired by https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
fzf_git_log() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 || return 1

  local diffviewer=""
  if [ ! "$(command -v diff-so-fancy >/dev/null 2>&1)" ]; then
    diffviewer='| diff-so-fancy'
  fi

  local commits=$( "${FZF_GIT_LOG_CMD[@]}" --color=always "$@" |
    fzf --ansi --multi --no-sort --reverse --height=100% \
    --bind \?:toggle-preview \
    --preview-window=right:60%:hidden \
    --preview="echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
    xargs -I@ sh -c 'git show --no-ext-diff --color=always @' $diffviewer")

    if [[ -n $commits ]]; then
      # the first sed expression removes escape sequences
      # the second sed expression captures just the SHA by matching:
      # "* | | * a8s87w ...." formed git log --graph lines
      # "a8s87w ..." formed git log lines
      local hashes=$(
        printf "$commits" |
        sed "s/\x1b\[[0-9;]*m//g" |
        sed -r "s/^[^a-z0-9]*([a-z0-9]+).*/\1 /"
      )
      git show $(echo $hashes)
    fi
}

alias glb="FZF_GIT_LOG_CMD=('git' 'l') fzf_git_log"
alias glgb="FZF_GIT_LOG_CMD=('git' 'lg') fzf_git_log"

# Enable completion for git aliases
if typeset -f "__git_complete" > /dev/null; then
  __git_complete glb _git_log
  __git_complete glgb _git_log
fi
