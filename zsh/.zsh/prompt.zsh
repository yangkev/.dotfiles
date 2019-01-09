# Prompt inspired by:
# https://joshdick.net/2017/06/08/my_git_prompt_for_zsh_revisited.html
# https://github.com/sindresorhus/pure

ZSH="$HOME/.zsh"

setopt prompt_subst
autoload -U colors && colors # Enable colors in prompt

# Echoes a username/host string when connected over SSH (empty otherwise)
ssh_info() {
  [[ "$SSH_CONNECTION" != '' ]] && echo '%(!.%F{red}.%F{yellow})%n%f@%F{green}%m%f:' || echo ''
}

# Echoes information about Git repository status when inside a Git repository
git_info() {

  # Exit if not inside a Git repository
  ! git rev-parse --is-inside-work-tree > /dev/null 2>&1 && return

  # Git branch/tag, or name-rev if on detached head
  local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

  local AHEAD="%F{red}⇡NUM%f"
  local BEHIND="%F{cyan}⇣NUM%f"
  local MERGING="%F{magenta}⚡︎%f"
  local UNTRACKED="%F{red}●%f"
  local MODIFIED="%F{yellow}●%f"
  local STAGED="%F{green}●%f"

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
  [ -n "$GIT_STATUS" ] && GIT_INFO+=( "%F{8}$GIT_STATUS%f" )
  [[ ${#DIVERGENCES[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)DIVERGENCES}" )
  [[ ${#FLAGS[@]} -ne 0 ]] && GIT_INFO+=( "${(j::)FLAGS}" )
  GIT_INFO+=( "%F{8}$GIT_LOCATION%f" )
  echo "${(j: :)GIT_INFO}"
}

# prompt_kevin_async_git_info is a wrapper around functions for gathering git information
prompt_kevin_async_git_info() {
  echo "$(git_info)"
}

# completed_callback handles completed async jobs
completed_callback() {
  local job=$1 exit_code=$2 stdout=$3 exec_time=$4 stderr=$5 next_pending=$6
  ( $exit_code ) && return

  typeset -gA prompt_components
  local do_render=0

  case $job in
    prompt_kevin_async_git_info)
      if [[ -n "$stdout" ]]; then
        prompt_components[git_info]="$stdout"
      else
        prompt_components[git_info]=""
      fi
      do_render=1
      ;;
  esac

  (( do_render )) && prompt_kevin_render
}

# prompt_kevin_render builds the $PROMPT variable and draws the prompt if necessary
prompt_kevin_render() {
  local -a prompt_parts=()

  # 0: ssh info
  local prompt_ssh_info="$(ssh_info)"
  if [[ -n $prompt_ssh_info ]]; then
    prompt_parts+=( $prompt_ssh_info )
  fi

  # 1: current working directory
  prompt_parts+=( '%F{magenta}%~%f' )

  # 2: git info
  if [[ -n "$prompt_components[git_info]" ]]; then
    prompt_parts+=( "$prompt_components[git_info]" )
  fi

  # 3: arrow
  prompt_parts+=( '%(?.%B%F{cyan}.%B%F{red})%(!.#.❯)%f%b ' )

  PROMPT="${(j: :)prompt_parts}"

  # don't force a re-draw unnecesarily if the new prompt is the same as the previous
  local expanded_prompt="${(S%%)PROMPT}"
  if [[ $1 != "precmd" && "$expanded_prompt" != "$prompt_kevin_last_prompt" ]]; then
    zle && zle reset-prompt
  fi
  typeset -g prompt_kevin_last_prompt="$expanded_prompt"
}

# prompt_kevin_precmd is a zsh hook function that is executed before each prompt.
# This precmd issues async jobs and renders the prompt.
prompt_kevin_precmd() {
  ((!${prompt_init:-0})) && {
    async_start_worker prompt_worker -u -n
    async_register_callback prompt_worker completed_callback
    typeset -g prompt_init=1
  }

  # Update the current working directory of the async worker.
  async_worker_eval prompt_worker builtin cd -q $PWD

  # start async jobs
  async_job prompt_worker prompt_kevin_async_git_info

  # render prompt
  prompt_kevin_render "precmd"
}

prompt_kevin_setup() {
  autoload -Uz add-zsh-hook
  autoload -Uz zsh/zle
  prompt_opts=(subst percent)
  if [ -f "$ZSH/zsh-async/async.zsh" ]; then
    source "$ZSH/zsh-async/async.zsh"
    async_init
    add-zsh-hook precmd prompt_kevin_precmd
    prompt_cleanup 'prompt_kevin_cleanup'
  else
    add-zsh-hook precmd prompt_kevin_render
  fi
}

prompt_kevin_cleanup() {
  async_flush_jobs prompt_worker
  async_stop_worker prompt_worker
}

prompt_kevin_setup "$@"
