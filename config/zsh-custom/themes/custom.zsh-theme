# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

function get_git_branch {
  echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null);
  # echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function get_git_remote {
  # echo $(git remote)
  echo $(git config --get branch.$branch.remote)
}


function my_git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  GIT_STATUS=$(git_prompt_status)
  [[ -n $GIT_STATUS ]] && GIT_STATUS=" $GIT_STATUS"
  echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/} $ZSH_THEME_GIT_PROMPT_SUFFIX"
}

my_host() {
  if [[ -n "$SSH_CLIENT" ]]; then
    print -n "@%m"
  fi
}


ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=") %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED=":"
ZSH_THEME_GIT_PROMPT_ADDED="+"
ZSH_THEME_GIT_PROMPT_MODIFIED="*"
ZSH_THEME_GIT_PROMPT_RENAMED="~"
ZSH_THEME_GIT_PROMPT_DELETED="!"
ZSH_THEME_GIT_PROMPT_UNMERGED="?"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%  "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}%{$reset_color%} %{$fg[yellow]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}%{$reset_color%} %{$fg_bold[red]%}%1{✗%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$reset_color%}"

PROMPT='%{$fg[white]%}%n$(my_host)%{$reset_color%} %{$fg_bold[blue]%}%4~%{$reset_color%} $(git_prompt_info)%{$reset_color%}
$ '
RPS1="${return_code}"
