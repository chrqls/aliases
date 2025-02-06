# ---------------- PATH ----------------
PATH_PROJECTS='~/projects'
PATH_FRONT=$PATH_PROJECTS'/ias'
PATH_BACK=$PATH_PROJECTS'/es'
#PATH_ZSH='~/.zshrc'
#PATH_COLA='/'

# ---------------- GENERAL ----------------
alias ll='ls -lAF'
alias la='ls -laAF'
alias helpp='history | grep'
#alias editzsh='vi '$PATH_ZSH
alias editaliases='vi '$PATH_PROJECTS'/aliases/.bash_aliases'
alias ea='editaliases'
alias bhl='bash -l'
#alias zhl='zsh -l'
#alias ktm='kitematic --no-sandbox &'
alias goh='cd ~'
alias gop='cd '$PATH_PROJECTS
alias gos='cd ~/stacks'
alias gof='cd '$PATH_FRONT
alias gob='cd '$PATH_BACK
alias kpp='keep-presence -s 40 -p 1'
alias switchjava='sudo update-alternatives --config java'

# ---------------- PROJECTS ----------------
# /!\ /!\ /!\i
# postgirl = GET
#GET() {
#    curl -H 'User:chrqls' -H 'Password:Passw0rd' 'http://127.0.0.1:8080/api/'$1
#}
# /!\ /!\ /!\

# npm run build
alias checkci='nvm use node && rm x.log && npm run build > x.log'
# npx http-server build

## Stack
PATH_EKS=$PATH_PROJECTS'/eptica-kick-starter'
alias sta=$PATH_EKS'/start-stack.sh'
alias sto=$PATH_EKS'/stop-stack.sh'
alias cre=$PATH_EKS'/create-stack.sh'
alias rem=$PATH_EKS'/remove-stack.sh'
alias inf=$PATH_EKS'/info-stack.sh'
alias crelocal='cre network && cre postgres && cre ese && cre els && cre keycloak && cre eks'
alias stalocal='sta network && sta postgres && sta ese && sta els && sta keycloak && sta eks'
alias ccsimulator='docker run --rm --name cc-simulator -e REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 -e EKS_BASE_URI=http://chrqlship:5000 -p 3000:3000 registry.eptica.com/eptica/cc-simulator:1.0.13'
alias staccs='sta network && sta postgres && sta ese && sta els && sta keycloak && sta eks && sta eksui && sta haproxy && ccsimulator'

alias intj='/home/chrqls/Téléchargements/Tools/idea-IU-232.10227.8/bin/idea.sh'
alias datedb='date +%g%V%w%H'
alias sendmail='cd ~/Téléchargements/Tools/EpticaTool-EMLemailSender && java -classpath "./mail.jar:./activation.jar" ./send2.java chrqlship 8823 .'
alias oldstaccs='REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 EKS_BASE_URI=http://chrqlship:5000 node app.js'

syncRoot() {
    current_stack=`git branch --show-current`
    #current_pwd=`pwd`
    #cd .. &&  mv $current_pwd $current_stack && cd $current_stack
    mkdir -p data.$current_stack
    rm data && ln -s data.$current_stack data
}

alias syncroot='current_stack=`git branch --show-current` && current_pwd=`pwd` && cd .. &&  mv $current_pwd $current_stack && cd $current_stack'
#alias test1=syncRoot
alias syncdata='current_stack=`git branch --show-current` && mkdir -p data.$current_stack && rm data && ln -s data.$current_stack data'
alias ssync='syncroot && syncdata'

goBranchAndSync()  {
    git checkout $1 && ssync && ll
}
alias goo=goBranchAndSync

## VPN (temp)
alias vpnu='sudo wg-quick up wg0'
alias vpnd='sudo wg-quick down wg0'
alias vpnt='ping 192.168.16.1'
alias vpns='sudo wg show && ifconfig wg0'

## Docker
alias dl='docker logs' # -f (hot refresh)
alias dps='docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Ports}}"' # {{.Image}}
alias stasel='docker run  -p 5900:5900 -p 4454:4444 --name "selenium-server-chrome" selenium/standalone-chrome-debug:3.141.59-bismuth'
alias stobt='docker kill $(docker ps -a -q)'
alias rembt='docker rm $(docker ps -a -q)'
alias stabt='mvn clean pre-integration-test -Pdev'
alias dpr='docker system prune --filter "until=4320h"' # Wenfei trick
alias dprv='docker system prune --volumes' # Wenfei trick

connectToContainer() {
    docker exec -it $1 bash
}
alias dei=connectToContainer

## Java
alias javav='sudo update-alternatives --config java'
## Maven
alias mvip='mvn clean install -PskipTests'
alias mvid='mvn clean install -DskipTests'
# alias mvn docker:stop -Pdev

## NPM
alias npml='npm list --depth=0' # -g

# ---------------- GIT ----------------
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
alias gdw='git diff --word-diff'
alias go='git checkout'

## Revert (unstage? uncommit ? lequel est lequel)
alias gau='git reset HEAD' # unstage a staged file
alias gcu='git reset --soft HEAD^' # revert to staged state
alias reset='git reset --hard'
alias ccc='git revert HEAD --no-edit'
alias gdelete='git push origin --delete' #<remote-branch-to-delete>

## More
# git switch -c TEKBVI-102 origin/TEKBVI-102
alias gra='git remote add'
#alias cola='python '$PATH_COLA'/Git\ Cola/bin/git-cola'
#alias gk='gitk --all&'
#alias gx='gitx --all'
#alias gt='git tag'
#alias gmv='git mv'
