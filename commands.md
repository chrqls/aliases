#### ng
```shell
ng serve 
  --delete-output-path=false 
  --port=4201 
  --host 127.0.0.1 
  --proxy-config ./node_modules/fwk-angular/proxy.conf.js
```

#### mvn
```bash
mvn clean install 
  -rf vsc-aftersale-libext/ 
  -DskipTests 
  -T 1C
```

#### json-server
```bash
json-server 
  --watch D:/path/to/database.json 
  --routes D:/path/to/routes.json'
```

#### Bash
Create a function with one parameter:
```bash
_say() {
  if [ -z $1 ]
    then
      echo wtf
    else
      echo $1
  fi
}
alias say=_say
```

Create a function with several parameters:
```bash
_sayAlso() {
  if [ -z $3 ]
    then
      echo -e '\n'$1'(): '$2
    else
      echo -e '\n'$1'('$2'): '$3
  fi
}
alias sayAlso=_sayAlso
```

Show export variables: `export -p`

#### Docker
Concernant l'installation:
```
sudo apt search docker
sudo apt install docker.io docker-compose
```

Insérer dans `/etc/hosts` la conf suivante et redémarrer docker avec `sudo systemctl restart docker`:
```
# Si Station admin
10.106.6.33	AZ017WB01G033 forge.diplomatie.gouv.fr gitlab-registry.forge.diplomatie.gouv.fr registry-1.docker.io
# si DevNG, Dev
10.1.150.31	AZ017WB01G033 forge.diplomatie.gouv.fr gitlab-registry.forge.diplomatie.gouv.fr registry-1.docker.io
```

Ajouter au groupe docker le user de la session:
```
sudo usermod -a -G docker $USER
```

Renseigner le dépôt des images: 
```
docker login artifactory-registry.domain.com
```

Pour lister les images: 
```
docker ps
docker images
```

Accéder en intéractif à son image:
```
docker exec -it <TAB_image> bash
```

Monter les services du projet ou un spécifique
```
docker-compose up -d <service_ou_pas> (postgres)
docker-compose up --build -V postgres (--build ?? -V ??)
```

Arrêter une image
```
docker stop <id>
docker-compose stop <id> (si au niveau du docker compose)
```

Supprimer une image:
```
docker rmi artifactory-registry.domain.com/docker-images/ci-tools:feat-add-python
docker rm <id>
docker-compose down <id> (si au niveau du docker compose)
```

Le `pull` permet de récupérer une image:
```
docker pull artifactory-registry.domain.com/docker-images/ci-tools:feat-add-python
sudo docker pull debian:stretch # si registry-1.docker.io est dans /etc/hosts
sudo docker pull gitlab-registry.forge.diplomatie.gouv.fr/library/debian:stretch # sinon
```

J'ai souvent consulté `/etc/docker/certs.d/artifactory-registry.domain.com/`.

Au bout du rouleau ? il reste une solution (spécifique au MAE je pense):
```
sudo apt -V install gnupg2 pass
```
#### Shell linux
systemctl
```
sudo systemctl restart docker
sudo systemctl status docker
```
