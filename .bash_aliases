# ---------------- PATH ----------------
PATH_PROJECTS='~/projects'
#PATH_FRONT=$PATH_PROJECTS'/ias'
#PATH_BACK=$PATH_PROJECTS'/es'
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
alias gok='cd ~/projects/eptica-kick-starter'
#alias gof='cd '$PATH_FRONT
#alias gob='cd '$PATH_BACK
alias kpp='keep-presence -s 40 -p 1'

# ---------------- PROJECTS ----------------
# /!\ /!\ /!\i
# postgirl = GET
#GET() {
#    curl -H 'User:chrqls' -H 'Password:Passw0rd' 'http://127.0.0.1:8080/api/'$1
#}
# /!\ /!\ /!\

# npm run build
# npx http-server build

## Kick starter
PATH_EKS=$PATH_PROJECTS'/eptica-kick-starter'
alias sta=$PATH_EKS'/start-stack.sh'
alias sto=$PATH_EKS'/stop-stack.sh'
alias cre=$PATH_EKS'/create-stack.sh'
alias rem=$PATH_EKS'/remove-stack.sh'
alias inf=$PATH_EKS'/info-stack.sh'

# KBUI
alias purgedata='cd ~/stacks/kbui && sudo rm -rf data/* && rm -f stack.properties.ports'
alias creback='cre network postgres ese els keycloak && cre eks'
alias staback='sta network postgres ese els keycloak && sta eks'
alias crefront='cre eksui haproxy ccsim'
alias stafront='sta eksui haproxy ccsim'
#alias ccslocal='REALM_URI=http://localhost:9070/realms/eks-tenant-1 EKS_BASE_URI=http://localhost:3001 EKS_CC_SERVICE_ACCOUNT_ID=ei_eks_cc_sa EKS_CC_SERVICE_ACCOUNT_SECRET=zRT5oQaqmw0bR9Yrn6R1SD5Ksx71W2dV node app.js'
alias ccslocal='REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 EKS_BASE_URI=http://localhost:3001 EKS_CC_SERVICE_ACCOUNT_ID=ei_eks_cc_sa EKS_CC_SERVICE_ACCOUNT_SECRET=zRT5oQaqmw0bR9Yrn6R1SD5Ksx71W2dV node app.js'
alias ccsdocker='REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 EKS_BASE_URI=http://chrqlship:9080/eksui node app.js'
#alias ccsold='docker run --rm --name cc-simulator -e                                                            REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 -e EKS_BASE_URI=http://chrqlship:5000 -p 3000:3000 registry.eptica.com/eptica/cc-simulator:1.0.13'
#alias ccsimu='docker run --rm --name cc-simulator --network=network-eksui --add-host=chrqlship:192.168.128.1 -e REALM_URI=http://chrqlship:9070/realms/eks-tenant-2 -e EKS_BASE_URI=http://chrqlship:5000 -p 3000:3000 registry.eptica.com/eptica/cc-simulator:1.0.13'


showHostForCCS() {
    docker inspect eks-resources-$1 | jq -r .[0].HostConfig.ExtraHosts
}
alias ccsip='showHostForCCS kbui'

#alias intj='/home/chrqls/Téléchargements/Tools/idea-IU-232.10227.8/bin/idea.sh'
alias intj='/home/chrqls/Téléchargements/Tools/idea-IU-262.8665.337/bin/idea.sh'
alias sendmail='cd ~/Téléchargements/Tools/EpticaTool-EMLemailSender && java -classpath "./mail.jar:./activation.jar" ./send2.java chrqlship 8823 .'

#alias syncroot='current_stack=`git branch --show-current` && current_pwd=`pwd` && cd .. &&  mv $current_pwd $current_stack && cd $current_stack'
#alias test1=syncRoot
#alias syncdata='current_stack=`git branch --show-current` && mkdir -p data.$current_stack && rm data && ln -s data.$current_stack data'
#alias ssync='syncroot && syncdata'

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
alias dils='docker images --format "{{.Size}}\t{{.ID}}\t{{.Repository}}:{{.Tag}}" | sort -h'
alias staselold='docker run  -p 5900:5900 -p 4454:4444 --name "selenium-server-chrome" selenium/standalone-chrome-debug:3.141.59-bismuth'
alias stasel='docker run  -p 5900:5900 -p 4454:4444 --name "selenium-server-chrome" selenium/standalone-chrome:125.0-chromedriver-125.0'
alias creBTstack='mvn clean pre-integration-test -Pdev'
alias stoBTstack='mvn docker:stop -Pdev'
alias remBTstack='mvn docker:remove -Pdev'
#alias stobt='docker kill $(docker ps -a -q)'
#alias rembt='docker rm $(docker ps -a -q)'
#alias stabt='mvn clean pre-integration-test -Pdev'
alias dirm='docker image rm'
alias drmif='docker rmi -f'
alias dpr='docker system prune --filter "until=4320h"' # Wenfei trick
alias dprv='docker system prune --volumes' # Wenfei trick

connectToContainer() {
    docker exec -it $1 bash
}
alias dei=connectToContainer

## Java
alias javaSwitch='sudo update-alternatives --config java'

## Maven
#alias mvip='mvn clean install -PskipTests'
#alias mvid='mvn clean install -DskipTests'
alias mvnieks='mvn clean install -DskipTests -DskipDocs -Dlicense.connectTimeout=200' # Arnaud trick
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

#alias gf='git fetch' # -p
alias pull='git pull origin'
#alias gpr='git pull --rebase origin'

alias checkci='nvm use node && rm -f x.log && npm run build > x.log'

_checkci() {
  nvm use node # optional
  rm -f x.log
  npm run build 2>&1 | tee x.log
}

pushFn() {

  local BLUEINFO='\033[0;36m'
  local GOLD='\033[0;33m'
  local SUCCESS='\033[1;32m'
  local DANGER='\033[0;1;5;31m'
  local NC='\033[0m' # NO COLOR

  # Getting arguments
  local EXTRA_ARGS="$@"

  # Checking CI...
  echo -e "${BLUEINFO}🔎 Building app...${NC}"

  # 	=> 0/1/2 is for stdin/stdout/stderr, so 2>&1 redirect errors to output
  # 	=> 'tee' is similar to 'echo'
  if _checkci | grep -q "ERR!"; then
    echo -e "\n${DANGER}❌ Build failed (ERR! found, see x.log). Push canceled.${NC}"
    return 1
  fi

  # Try pushing...
  local output
  output=$(git push origin $EXTRA_ARGS 2>&1)
  local push_code=$? # equal 0 if push worked

  # If remote branch not already created, we set the upstream
  if echo "$output" | grep -q -- "--set-upstream"; then
    echo -e "\n${GOLD}⏳ Branch unknown on origin. Set upstream... 🚀${NC}"
    local current_branch=$(git symbolic-ref --short HEAD)
    git push --set-upstream origin "$current_branch" $EXTRA_ARGS > /dev/null 2>&1
    echo -e "${SUCCESS}✅ CI compliant and remote branch created ! ${NC}"

  # Else if already created and and push succeeded (exit code 0)
  elif [ $push_code -eq 0 ]; then
      echo -e "\n${SUCCESS}✅ CI compliant and commit pushed (args: ${EXTRA_ARGS:-none}) !${NC}"
      #echo "$output" | grep -E "To | [a-f0-9]+\.\.[a-f0-9]+" 
  
  # Else if other error
  else
      echo -e "\n${DANGER}💀 Git push failed: ${NC}"
      echo "$output"
  fi
}
alias puush=pushFn
alias push='git push origin'
alias pushb='git push --set-upstream origin $(git symbolic-ref --short HEAD)'

rebaseCommits() {
    git rebase -i HEAD~$1 
}

alias gr='git rebase' # --continue, --abort
alias gri=rebaseCommits
#alias wip='git diff --stat HEAD~5 HEAD'

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
#alias gmv='git m2>&1v'
