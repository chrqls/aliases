# --- PATH ---
PATH_PROJECTS='~/projects'
PATH_FRONT=$PATH_PROJECTS'/gobox-front'
PATH_BACK=$PATH_PROJECTS'/auvray-back-end'
PATH_ZSH='~/.zshrc'
PATH_COLA='/c/Program\ Files\ (x86)'

# GENERAL
alias ll='ls -lAF'
alias la='ls -laAF'
alias helpp='history | grep'
alias editzsh='vi '$PATH_ZSH
alias editaliases='vi '$PATH_PROJECTS'/aliases/.bash_aliases'
alias bhl='bash -l'
alias zhl='zsh -l'
alias ktm="kitematic --no-sandbox &"

# PROJECTS
GET() {
    curl -H 'User:chrqls' -H 'Password:Passw0rd' 'http://127.0.0.1:8080/api/'$1
}
#alias esl='npm run lint'
#alias postgirl=GET
alias npml='npm list --depth=0' # -g
alias goh='cd ~'
alias gop='cd '$PATH_PROJECTS
alias bfr='cd '$PATH_PROJECT'/bfr'
alias crrv='cd '$PATH_PROJECT'/crrv-projet'
alias gof='cd '$PATH_PROJECT'/generique-ui'
alias gob='cd '$PATH_PROJECT'/generique-api'

# GIT
## Stash
stashShow() {
    git stash show -p stash@{$1} 
}
stashPop() {
    git stash pop stash@{$1} 
}
stashDrop()  {
    git stash drop stash@{$1}
}
alias stash='git stash'
alias stal='git stash list'
alias stas=stashShow
alias pop=stashPop
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
alias gca='git commit --amend' # plus besoin du --no-edit ?

alias gf='git fetch' # -p
alias pull='git pull origin'
alias gpr='git pull --rebase origin'
alias push='git push origin'
alias pushb='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

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
alias gub='git remote update origin --prune'
alias gd='git diff'
alias go='git checkout'

## Revert (unstage? uncommit ? lequel est lequel)
alias gau='git reset HEAD' # unstage a staged file
alias gcu='git reset --soft HEAD^' # revert to staged state
alias reset='git reset --hard'
alias ccc='git revert HEAD --no-edit'
alias gdelete='git push origin --delete' #<remote-branch-to-delete>

## More
alias gra='git remote add'
alias cola='python '$PATH_COLA'/Git\ Cola/bin/git-cola'
#alias gk='gitk --all&'
#alias gx='gitx --all'
#alias gt='git tag'
#alias gmv='git mv'
