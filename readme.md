# Docker #

- Aplicações que rodam em container tem menos chances de afetar outras aplicações executando no mesmo host
- Menor consumo de recursos de máquina se comparado a uma VM
- Menos tempo gasto com administração de máquinas e custo de sistema operacional
- Nativamente mais seguro em razão de rodar isoladamente
- Possibilidade de controlar uso máximo de memória, cpu, rede, portas, etc.
- Sistema de arquivos totalmente a parte do sistema de arquivos do host
- Versão para executar containers Windows e Linux

## Primeiro container ##

```powershell
docker run --name first-container hello-world
```

## Criar container a partir de uma imagem oficial ##

- Procurar o nome do programa em https://hub.docker.com

- Executar o comando run

```powershell
docker run node:latest node --version
```

## Outras opções do comando run ##

```powershell

docker run `
    --name example-nodejs-1 `
    --volume D:\projetos\dojos\docker\example-nodejs:/app `
    --publish 9999:3000 `
    node:latest `
    node /app/index.js

# Remover o container
docker rm --force example-nodejs-1

# Executar o container em background
docker run --name example-nodejs-2 --detach --publish 9999:3000 --volume ${PWD}/example-nodejs:/app node:latest node /app/index.js

# Consultar logs
docker logs example-nodejs-2
```

## Dashboards Gráficas ##

- Docker Desktop
- Extensão Docker no VS Code
- Portainer

    ```powershell
    docker volume create portainer_data
    docker run -d -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock `
        -v portainer_data:/data portainer/portainer
    ```

## Imagem, Dockerfile e docker build ##

- Imagem é um "arquivo zip" com a sua aplicação e todas as dependências que ela precisa para ser executada 

- Para criar uma imagem, é necessário um arquivo Dockerfile e comando de build

```powershell
# compilar minha aplicação
dotnet publish ./example-asp-core/ --output ./example-asp-core/app --configuration Release
# compilar imagem docker
docker build -t my-app --file ./example-asp-core/Dockerfile ./example-asp-core
docker run --name my-app-container -p 5000:80  my-app

# podemos usar a versão do build no nome da imagem
docker build -t my-app:1.0.0 --file ./example-asp-core/Dockerfile ./example-asp-core
```

- As imagens podem ser simples, apenas uma cópia da sua aplicação, ou podem descrever inclusive o processo de build, testes e incluir todas as depêndencias da sua aplicação.


## Docker Push ##

- Para criar um container a partir da imagem da minha aplicação, preciso publicar essa imagem em um registro
```powershell
# logar na hub.docker.io, em outra nuvem ou em um registro local
docker login

# enviar imagem para a nuvem (deve usar seu usuário no site do docker como prefixo do nome da imagem)
docker tag my-app:latest mydockeruser/myapp:latest
docker push mydockeruser/myapp:latest
```
## Docker Compose ## 

- Com o docker-compose é possível subir localmente diversas aplicações ao mesmo tempo com um comando
    - Facilita os testes com aplicações que possuem diversas dependências

```powershell
docker-compose -f example-asp-core\integration.docker-compose.yaml up
```

## VS Code Remote Container ##

- O VS Code possui uma extensão que permite desenvolver e debugar diretamente dentro do container

## Docker Swarm (Orquestrador) ## 

- Permite subir e atualizar aplicações rodando em container de maneira simples em cluster Docker Swarm

```powershell
# criando o cluster
docker swarm init

# realizar o deploy ou atualização de uma aplicação no modo swarm
docker stack deploy -c example-asp-core\swarm.docker-compose.yaml swarmdemo
```

## Links ##

- Docker
    - https://docs.docker.com/
    - https://www.docker.com/play-with-docker
    - https://github.com/docker/labs

- Microsoft
    - https://docs.microsoft.com/dotnet/core/docker/introduction

- https://www.portainer.io/
    - Dashboard para gerenciar containers
    
