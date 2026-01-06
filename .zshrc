export EDITOR="vi"

# Use ctrl+U to clear a line to the beginning
bindkey -e
bindkey \^U backward-kill-line

#### Homebrew

eval "$(/opt/homebrew/bin/brew shellenv)"

#### Git Aliases

alias main="git checkout main && git pull origin main"
alias master="git checkout master && git pull origin master"
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
alias create_pr='gh pr create -d --fill'


prune_local_branches() {
    git fetch --prune
	git branch -vv | grep ': gone' | awk '{print $1}' | xargs git branch -D
}


gcbb() {
  local branch raw msg
  branch=$(git branch --show-current 2>/dev/null)

  if [[ -z "$branch" ]]; then
    echo "Not in a Git repo or unable to detect branch."
    return 1
  fi

  # Replace underscores with spaces
  raw="${branch//_/ }"

  # Capitalize ONLY the first letter (zsh syntax)
  msg="${raw[1]:u}${raw[2,-1]}."

  echo "Committing with message: \"$msg\""
  git commit -m "$msg"
}

alias flow='rb && ris && ruff && git add . && gcbb && create_pr'
alias amend='rb && ris && ruff && git add . && git commit --amend --no-edit && git push --force-with-lease'


#### PROMPT

function parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

COLOR_DEF=$'%{\e[0m%}'
COLOR_USR=$'%{\e[38;5;243m%}'
COLOR_DIR=$'%{\e[38;5;197m%}'
COLOR_GIT=$'%{\e[38;5;39m%}'
setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}%1d ${COLOR_GIT}$(parse_git_branch)${COLOR_DEF} $ '

#### Load Git completion

# See https://www.oliverspryn.com/blog/adding-git-completion-to-zsh
zstyle ':completion:*:*:git:*' script ~/.zsh/git-completion.bash
fpath=(~/.zsh $fpath)

autoload -Uz compinit && compinit

#### System set up

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias python=python3
alias pip=pip3

source ~/.docker/init-zsh.sh || true # Added by Docker Desktop


#### TC

export HEROKU_APP=backend-api-development

alias rb='poetry run black backend_api/'
alias ris='poetry run isort backend_api/'
alias rmp='poetry run mypy backend_api --exclude backend_api/tests'
alias rpy='poetry run pylint backend_api/'
alias ruff='poetry run ruff check --fix backend_api/'
alias autoflake='poetry run autoflake --remove-all-unused-imports --ignore-init-module-imports --in-place --recursive backend_api'
alias tests='poetry run python manage.py test backend_api'
alias run_ci='./scripts/run_ci.sh --no-test'
alias run_ci_with_test='./scripts/run_ci.sh'
alias runserver='poetry run python manage.py runserver 8001'
alias mm='poetry run python manage.py makemigrations'
alias rmi='poetry run python manage.py migrate'
alias heroku_shell_dev='heroku run python manage.py shell --app backend-api-development'
alias heroku_shell_prod='heroku run python manage.py shell --app turfcoach-backend-api-prod'
alias heroku_logs_dev='heroku logs --tail  -n 1500 --app backend-api-development'
alias heroku_logs_prod='heroku logs --tail  -n 1500 --app turfcoach-backend-api-prod'
alias heroku_logs_scheduler_dev='heroku logs --tail -n 1500 --dyno scheduler --app backend-api-development'
alias heroku_logs_scheduler_prod='heroku logs --tail -n 1500 --dyno scheduler --app turfcoach-backend-api-prod'


##### Ukumi

alias u_ci='uv tool run ruff check . && uv tool run ruff format . && uv tool run pyrefly check . && (cd activities && uv run pytest && cd ..)'

##### Leximate

alias l_run_ci='./scripts/run_ci.sh'
alias l_flow='git add . && gcbb && create_pr'
alias l_amend='git add . && git commit --amend --no-edit && git push --force-with-lease'

