# Various third party cli tools' settings

# fzf
export FZF_DEFAULT_OPTS="\
  --multi \
  --cycle \
  --height=60% \
  --preview='head -$LINES {}' \
  --preview-window=right:50%:hidden \
  --bind ?:toggle-preview"

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

# Base 16 colors
BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Gruvbox colors
VIM_BUNDLE="$HOME/.vim/bundle"
[ -n "$PS1" ] && [ -s "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh" ] && source "$VIM_BUNDLE/gruvbox/gruvbox_256palette.sh"
