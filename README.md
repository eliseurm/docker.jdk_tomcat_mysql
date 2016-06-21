## Dockerfile com Jdk, Tomcat e MySql


### Este repositorio contem **Dockerfile** com:

1. Jdk - Java Oracle 8
2. Tomcat 9
3. MySql 5



### Imagem baseada em Ubuntu

* [ubuntu:14.04]


### Instalação

1. Fazer Download deste repositorio e depois aplicar o comando: `docker pull eliseurm/jdk_tomcat_mysql`

   (outra opção, você pode fazer o buil da imagem direto do repositorio Dockerfile: `docker build -t="eliseurm/jdk_tomcat_mysql" github.com/eliseurm/docker.jdk_tomcat_mysql`)


### Uso

    docker run -d --name web eliseurm/jdk_tomcat_mysql

