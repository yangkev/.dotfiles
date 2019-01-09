# Prompt inspired by https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
ZSH="$HOME/.zsh"

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%{$fg[red]%}.%{$fg[yellow]%})%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%{$fg[red]%}⇡NUM%{$reset_color%}"
  local BEHIND="%{$fg[cyan]%}⇣NUM%{$reset_color%}"
  local MERGING="%{$fg[magenta]%}⚡︎%{$reset_color%}"
  local UNTRACKED="%{$fg[red]%}●%{$reset_color%}"
  local MODIFIED="%{$fg[yellow]%}●%{$reset_color%}"
  local STAGED="%{$fg[green]%}●%{$reset_color%}"

  local -a DIVERGENCES
  local -a FLAGS

  local NUM_AHEAD="$(git log --oneline @{u}.. 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_AHEAD" -gt 0 ]; then
    DIVERGENCES+=( "${AHEAD//NUM/$NUM_AHEAD}" )
  fi

  local NUM_BEHIND="$(git log --oneline ..@{u} 2> /dev/null | wc -l | tr -d ' ')"
  if [ "$NUM_BEHIND" -gt 0 ]; then
    DIVERGENCES+=( "${BEHIND//NUM/$NUM_BEHIND}" )
  fi

  local GIT_DIR="$(git rev-parse --git-dir 2> /dev/null)"
  if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
    FLAGS+=( "$MERGING" )
  fi

  if [[ -n $(git ls-files --other --exclude-standard 2> /dev/null) ]]; then
    FLAGS+=( "$UNTRACKED" )
  fi

  if ! git diff --quiet 2> /dev/null; then
    FLAGS+=( "$MODIFIED" )
  fi

  if ! git diff --cached --quiet 2> /dev/null; then
    FLAGS+=( "$STAGED" )
  fi

  local -a GIT_INFO
  GIT_INFO+=( "%{\e[90m%}" )
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "$GIT_STATUS" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "%{\e[90m%}$GIT_LOCATION%{$reset_color%}" )
  echo "${(j: :)GIT_INFO}"
}

prompt_kevin_async_git_info() {
  local worker="$1"
}

completed_callback() {
  local job=$1 exit_code=$2 stdout=$3 exec_time=$4 stderr=$5 next_pending=$6
  ( $exit_code ) && return

  typeset -gA prompt_components
  local do_render=0

  case $job in
    prompt_kevin_async_git_info)
      if [[ -n "${stdout}" ]]; then
        prompt_components[git_info]=$stdout
        do_render=1
      fi
      ;;
  esac

  (( do_render )) && prompt_kevin_render
}


prompt_kevin_render() {
  local -a prompt_parts=()

  prompt_parts+=( '$(ssh_info)' )
  prompt_parts+=( '%{$fg[magenta]%}%~%f' )
  prompt_parts+=( '$(git_info)' )
  prompt_parts+=( '%(?.%{$fg_bold[cyan]%}.%{$fg_bold[red]%})%(!.#.❯)%{$reset_color%} ' )

  PROMPT="${(j: :)prompt_parts}"

  if [[ $1 != "precmd" ]]; then
    zle reset-prompt
  fi
}

prompt_kevin_precmd() {
  ((!${prompt_init:-0})) && {
    async_start_worker prompt_worker -u -n
    async_register_callback prompt_worker completed_callback
    typeset -g prompt_init=1
  }

  # start async jobs
  async_job prompt_worker prompt_kevin_async_git_info

  # render prompt
  prompt_kevin_render "precmd"
}

prompt_kevin_setup() {
  prompt_opts=(subst percent)
  if [ -f "$ZSH/zsh-async/async.zsh" ]; then
    source "$ZSH/zsh-async/async.zsh"
    async_init
    autoload -Uz zsh/zle
    autoload -Uz add-zsh-hook
    add-zsh-hook precmd prompt_kevin_precmd
    prompt_cleanup 'prompt_kevin_cleanup'
  fi
}

prompt_kevin_cleanup() {
  async_flush_jobs prompt_worker
  async_stop_worker prompt_worker
}

prompt_kevin_setup "$@"
