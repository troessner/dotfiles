export EDITOR="vi"

# Use ctrl+U to clear a line to the beginning
bindkey -e
bindkey \^U backward-kill-line

##########
# RBENV

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

#########
# Homebrew

eval "$(/opt/homebrew/bin/brew shellenv)"

##########
# NVM 
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion


##########
# Aliases

# Ruby / Rails
alias bxr="bundle exec rake"
alias reset_db="bin/rails db:test:prepare"

# git aliases
alias main="git checkout main && git pull origin main"
alias master="git checkout master && git pull origin master"
alias development="git checkout development && git pull origin development"
alias g='git'
alias gs='git status'
alias ga='git add'
alias gb='git branch'
alias gci='git commit'
alias gd='git diff'
alias gco='git checkout'
alias gap='git add -p'
alias gl='git log --oneline'
alias gpl='git pull'
alias grb='git rebase'
alias grbm='git rebase main'
alias gpsf='git push --force-with-lease'
alias gps='git push'
alias gca='git commit --amend --no-edit'
alias gdc='git diff --cached'
alias gcob='git checkout -b'
alias gcim='git commit -m'
alias gsh='git show'
alias gshl='git show HEAD'
alias gunstage='git restore --staged'
alias gst='git stash'
alias gstp='git stash pop'
alias glp='git log --patch'
alias grslc='git reset --soft HEAD~1'
alias gsw='git switch'
alias amend_and_force_push='git commit --amend --no-edit && git push --force-with-lease'
alias create_pr='gh pr create --fill'

##########
# PROMPT

function parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%{\e[0m%}'
COLOR_USR=$'%{\e[38;5;243m%}'
COLOR_DIR=$'%{\e[38;5;197m%}'
COLOR_GIT=$'%{\e[38;5;39m%}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%1d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

##########
# Load Git completion
# See https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

#########
# Python

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias python=python3
alias pip=pip3
alias black_check='poetry run black --check --diff dags/ test/'
alias black_fix='poetry run black dags/ test/'
alias mypy_check='poetry run mypy --strict --allow-untyped-decorators dags/ test/'
alias activate_venv='source venv/bin/activate'
alias rt='poetry run pytest'

export PATH="/Users/troessner/.local/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/troessner/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/troessner/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/troessner/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/troessner/bin/google-cloud-sdk/completion.zsh.inc'; fi
