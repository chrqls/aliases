# --- PATH ---
export PATH_USER='/Users/chrqls'
export PATH_PROJECTS=$PATH_USER'/Documents/github\ forks'
export PATH_FRONT=$PATH_PROJECTS'/fridge'
export PATH_BACK=$PATH_PROJECTS'/backend'
export PATH_ZSH='~/.zshrc'
export PATH_COLA='/c/Program\ Files\ (x86)'

export REST_URL=http://127.0.0.1:8080/Bridge

# GENERAL
alias ll='ls -lAF'
alias la='ls -laAF'
alias helpp='history | grep'
alias editzsh='vi '$PATH_ZSH
alias editaliases='vi '$PATH_PROJECTS'/aliases/.bash_aliases'
alias bhl='bash -l'
alias zhl='zsh -l'

## Project
GET() {
    curl -H 'User:quelosch' -H 'Password:kikooL0l' 'http://127.0.0.1:8080/Bridge/rest/'$1
}
startFront() {
  if [ -z $1 ]
    then
      ng serve --delete-output-path=false --port=4201 --host 127.0.0.1 --proxy-config ./node_modules/fwk-angular/proxy.conf.js
    else
      ng serve --delete-output-path=false --port=$1 --host 127.0.0.1 --proxy-config ./node_modules/fwk-angular/proxy.conf.js
  fi
}
#alias esl='npm run lint'
alias postgirl=GET
alias start=startFront
alias npml='npm list --depth=0' # -g
#alias my_json_server='clear && json-server --watch D:/path/to/database.json --routes D:/path/to/routes.json'
alias goh='cd ~'
alias gou='cd '$PATH_USER
alias gop='cd '$PATH_PROJECTS
alias gof='cd '$PATH_FRONT
alias gob='cd '$PATH_BACK
#alias mmvn='mvn clean install -rf vsc-aftersale-libext/ -DskipTests -T 1C'

# GIT
## Stash
stashShow() {
    git stash show -p stash@{$1} 
}
stashDrop()  {
    git stash drop stash@{$1}
}
alias stash='git stash'
alias stal='git stash list'
alias stas=stashShow
alias stadelete=stashDrop
#alias stap='sudo git stash && sudo git pull && sudo git stash pop'

## Log
alias gl='git cf'
#alias ghl='git hist --max-count=15'
#alias gf='git full'

## Commit/Fetch/Push/Conflicts

formattedMessage() {
  if [ -z $3 ]
    then
      echo -e '\n'$1'(): '$2
    else
      echo -e '\n'$1'('$2'): '$3
  fi
}

autoCommit() {
    git commit -m $(formattedMessage $1 $2 $3) 
}

alias gm=formattedMessage
alias gac=autoCommit

alias gc='git commit -m'
alias gca='git commit --amend --no-edit'

alias gf='git fetch' # -p
alias pull='git pull origin'
alias gpr='git pull --rebase origin'
alias push='git push origin'

rebaseCommits() {
    git rebase -i HEAD~$1 
}

alias gr='git rebase' # --continue, --abort
alias gri=rebaseCommits

## General
alias gs='git status'
alias ga='git add'
alias gaa='git add -A'
alias grm='git rm' # --cached: stage the file for deletion
alias gsd='git ls-files --deleted'
alias gb='git branch'
alias gd='git diff'
alias go='git checkout'

## Revert (unstage? uncommit ? lequel est lequel)
alias cca='git reset HEAD'
alias gu='git reset --hard'
alias ccc='git revert HEAD --no-edit'
alias gdelete='git push origin --delete' #<remote-branch-to-delete>

## More
alias gra='git remote add'
alias cola='python '$PATH_COLA'/Git\ Cola/bin/git-cola'
#alias gk='gitk --all&'
#alias gx='gitx --all'
#alias gt='git tag'
#alias gmv='git mv'
