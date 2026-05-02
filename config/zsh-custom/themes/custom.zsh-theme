# ZSH Theme - Preview: https://cl.ly/f701d00760f8059e06dc
# Thanks to gallifrey, upon whose theme this is based

local return_code="%(?..%{$fg_bold[red]%}%? ↵%{$reset_color%})"

my_host() {
  if [[ -n "$SSH_CLIENT" ]]; then
    print -n "@%m"
  fi
}

# Unused –
function get_git_branch {
  echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null);
}

function get_git_remote {
  echo $(git config --get branch.$branch.remote)
}

function parse_git_unpushed {
  local branch=`get_git_branch`
  local remote=`get_git_remote`
  if [[ "$remote" == "" ]]; then
    # No remote
    echo -e "❌"
  else
    local pushed=$(git branch -v | grep "^* $branch")
    if [[ $pushed =~ "\[ahead [0-9]*" ]]
    then
      # Unpushed
      echo -e "🌱"
    else
      # Pushed
      echo -e "🌼"
    fi
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[yellow]%}  "
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"

ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg_bold[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$reset_color%}"

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[red]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[red]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[red]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[red]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[red]%}✭%{$reset_color%}"

PROMPT='%{$fg[white]%}%n$(my_host)%{$reset_color%} %{$fg_bold[blue]%}%4~%{$reset_color%} $(git_prompt_info)$(git_prompt_status)$(parse_git_unpushed)%{$reset_color%}
$ '
RPS1="${return_code}"
