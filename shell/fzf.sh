# fzf customizations
[ "$(command -v fzf >/dev/null 2>&1)" ] && return

KEYBINDINGS="\
?:toggle-preview,\
ctrl-d:half-page-down,\
ctrl-u:half-page-up,\
ctrl-f:page-down,\
ctrl-b:page-up,\
alt-j:preview-down,\
alt-k:preview-up,\
alt-f:preview-page-down,\
alt-b:preview-page-up"

export FZF_DEFAULT_OPTS="\
  --multi \
  --cycle \
  --height=60% \
  --preview='head -$LINES {}' \
  --preview-window=right:50%:hidden \
  --bind=$KEYBINDINGS"

if [ ! "$(command -v rg >/dev/null 2>&1)" ]; then
  export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
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

# fzf_git_log allows using fzf as a git log browser with the ability to preview commit diffs (with git show).
# Inspired by https://bluz71.github.io/2018/11/26/fuzzy-finding-in-bash-with-fzf.html
fzf_git_log() {
  [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1 || return 1

  local diffviewer=""
  if [ ! "$(command -v diff-so-fancy >/dev/null 2>&1)" ]; then
    diffviewer='| diff-so-fancy'
  fi
  local commits=$(git lg --color=always "$@" |
    fzf --ansi --multi --no-sort --reverse --height=100% \
    --bind ?:toggle-preview \
    --preview-window=right:60%:hidden \
    --preview="echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
    xargs -I@ sh -c 'git show --no-ext-diff --color=always @' $diffviewer")

    if [[ -n $commits ]]; then
        local hashes=$(printf "$commits" | cut -d' ' -f2 | tr '\n' ' ')
        git show $hashes
    fi
}

alias glb="fzf_git_log"
