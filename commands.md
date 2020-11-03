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
