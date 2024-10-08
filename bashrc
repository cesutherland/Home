# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# case-insensitive completion
set completion-ignore-case on

# GIT
function git_prompt_status() { # for future use, from oh my zsh
  local index=$(git status --porcelain 2> /dev/null)
  local gitstatus=""

  if $(echo "$index" | grep '^?? ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  if $(echo "$index" | grep '^A  ' &> /dev/null); then
    gitstatus="$gitstatus"
  elif $(echo "$index" | grep '^M  ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  if $(echo "$index" | grep '^ M ' &> /dev/null); then
    gitstatus="$gitstatus"
  elif $(echo "$index" | grep '^AM ' &> /dev/null); then
    gitstatus="$gitstatus"
  elif $(echo "$index" | grep '^ T ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  if $(echo "$index" | grep '^R  ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  if $(echo "$index" | grep '^ D ' &> /dev/null); then
    gitstatus="$gitstatus"
  elif $(echo "$index" | grep '^AD ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  if $(echo "$index" | grep '^UU ' &> /dev/null); then
    gitstatus="$gitstatus"
  fi

  echo "$gitstatus"
}

function get_git_branch {
  echo $(git rev-parse --abbrev-ref HEAD 2> /dev/null);
  # echo $(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

function get_git_remote {
  # echo $(git remote)
  echo $(git config --get branch.$branch.remote)
}

function parse_git_unpushed {
  local branch=`get_git_branch`
  local remote=`get_git_remote`
  if [[ "$remote" == "" ]]; then
    # No remote
    # echo -e "\001\033[1;31m\002✪"
    echo -e "❌"
  else
    local pushed=$(git branch -v | grep "^* $branch")
    if [[ $pushed =~ ("[ahead "([[:digit:]]*).*]) ]]
    then
      # Unpushed
      # echo -e "\001\033[1;31m\002↑\001\033[0m\002"
      echo -e "🌱"
    else
      # Pushed
      # echo -e "\001\033[1;32m\002❀\xE2\x80\x89\001\033[0m\002"
      echo -e "🌼"
    fi
  fi
}

parse_git_dirty() {
  if [[ -n $(git status -s 2> /dev/null) ]]; then
    # echo -e "\001\033[1;31m\002✗\001\033[0m\002"
    echo -e "⚡"
  fi
}

function parse_git_branch {
  local branch=`get_git_branch`
  local remote=`get_git_remote`

  if [[ $branch != "" && $remote != "" && $remote != "origin" ]]; then
    branch="$remote\001\033[1;34m\002/\001\033[1;33m\002$branch"
  fi

  [[ $branch ]] && echo -e "\e[1;33m $branch\001\033[0m\002 $(parse_git_dirty)$(parse_git_unpushed)"
  #║┃•∙
}

PS1='\u@\h \[\e[1;34m\]\w\[\e[m\] $(parse_git_branch)\n$ '



# RVM
rvm_path="$HOME/.rvm"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/bin" ]] && export PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ASDF
export ASDF_DIR="$HOME/.asdf"
[ -s "$ASDF_DIR/asdf.sh" ] && . $ASDF_DIR/asdf.sh
[ -s "$ASDF_DIR/completions/asdf.bash" ] && . $ASDF_DIR/completions/asdf.bash

# PIP
export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')
export PATH=$PY_USER_BIN:$PATH

# Local
export PATH=$PATH:$HOME/.bin:$HOME/.local/bin
export PATH=$PATH:$HOME/.composer/vendor/bin 

# neovim
if type nvim > /dev/null 2>&1; then
    alias vim='nvim'
fi

# VI
set -o vi
EDITOR=/usr/bin/vim

# tmux
source ~/.bin/tmuxinator.bash

# Aliases
alias shit='git'
alias gits='git status'
alias gc='git commit'
alias gd='git diff'
alias ga='git add'
alias gp='git push'
alias tma='tmux attach -d -t'

function gclean() {
  BRANCH="${1:-master}"
  echo $BRANCH
  git branch --merged $BRANCH | grep -v "\* $BRANCH" | xargs -n 1 git branch -d
}

function ackr () {
  ack "$1" -l | xargs perl -pi -E "$2"
}

# k8s
[[ -s $HOME/.kube/completion.bash.inc ]] && source "$HOME/.kube/completion.bash.inc"
alias k='kubectl'

# Squarespace
[[ -s ~/Projects/kubectl-plugins ]] && export PATH=$PATH:~/Projects/kubectl-plugins

# Volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

# Rust
. "$HOME/.cargo/env"

# go
export PATH=$PATH:/usr/local/go/bin
