export EDITOR="vi"

##########
# RBENV

eval "$(rbenv init -)"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

##########
# NVM 

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

##########
# Python

alias brew='env PATH="${PATH//$(pyenv root)\/shims:/}" brew'
export AIRFLOW_HOME=~/Applications/airflow

##########
# APPS

# Textmate
path+=/Users/troessner/bin
 
##########
# Aliases

# Ruby / Rails
alias bxr="bundle exec rake"
alias reset_db="bin/rails db:test:prepare"

# git aliases
alias main="git checkout master && git pull origin master"
alias master="git checkout master && git pull origin master"
alias development="git checkout master && git pull origin master"
alias g='git'
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gci='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gap='git add -p'
alias gl='git log'
alias gpl='git pull'
alias grb='git rebase'
alias grbm='git rebase master'
alias gpsf='git push --force-with-lease'
alias gps='git push'
alias gca='git commit --amend'
alias gdc='git diff --cached'
alias gcob='git checkout -b'
alias gcim='git commit -m'

##########
# PROMPT

function parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'\e[0m'
COLOR_USR=$'\e[38;5;243m'
COLOR_DIR=$'\e[38;5;197m'
COLOR_GIT=$'\e[38;5;39m'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%~ ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

##########
# Load Git completion
# See https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

#########
# Load other dot files
#

source ~/.setting_io
