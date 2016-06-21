## Dockerfile com Jdk, Tomcat e MySql


### Este repositorio contem **Dockerfile** com:

1. Jdk - Java Oracle 8
2. Tomcat 9
3. MySql 5



### Imagem baseada em Ubuntu

* [ubuntu:14.04]


### Instalação

* Fazer Download deste repositorio e fazer a imagem com buil deste Dockerfile: 
   `docker build -t="eliseurm/jdk_tomcat_mysql" github.com/eliseurm/docker.jdk_tomcat_mysql`


### Uso
* Aplique o comando abaixo
    `docker run -d --name web eliseurm/jdk_tomcat_mysql`

