#
# Docker file com os seguintes itens instalados
#
# Ubuntu 14.04
# Java oracle 8 - https://github.com/dockerfile/java/blob/master/oracle-java8/Dockerfile
# TomCat 9
# MySql - https://github.com/dockerfile/mysql
#

# Pull base - Imagem do ubuntu.
FROM ubuntu:14.04
MAINTAINER Eliseu Rodrigues Menezes <eliseu@eliseu.eng.br>

# -------------------------
#    Instala Miscelanias
# -------------------------
RUN \
  apt-get update && \
  apt-get install -y  --no-install-recommends build-essential && \
  apt-get install -y  --no-install-recommends software-properties-common && \
  apt-get install -y  --no-install-recommends curl man unzip wget nano && \
  apt-get install -yq --no-install-recommends pwgen ca-certificates 


# -------------------------
#    Instala Java.
# -------------------------
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer  

# Define variaveis de memoria
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle


# --------------------
#    Instala MySQL.
# --------------------
RUN \
  DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  sed -i 's/^\(log_error\s.*\)/# \1/' /etc/mysql/my.cnf && \
  echo "mysqld_safe &" > /tmp/config && \
  echo "mysqladmin --silent --wait=30 ping || exit 1" >> /tmp/config && \
  echo "mysql -e 'GRANT ALL PRIVILEGES ON *.* TO \"root\"@\"%\" WITH GRANT OPTION;'" >> /tmp/config && \
  bash /tmp/config 


# --------------------
#    Tomcat 9
# --------------------

ENV TOMCAT_MAJOR_VERSION 9
ENV TOMCAT_MINOR_VERSION 9.0.0.M8
ENV CATALINA_HOME /tomcat

# INSTALL TOMCAT
RUN \
  wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  wget -qO- https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  tar zxf apache-tomcat-*.tar.gz && \
  rm apache-tomcat-*.tar.gz && \
  mv apache-tomcat* tomcat

ADD create_tomcat_admin_user.sh /create_tomcat_admin_user.sh


# ----------------------------------
#    Remove aquivos temporarios
# ----------------------------------
RUN \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  rm -f /tmp/config 



# ----------------------------------
#    Configuracoes finais
# ----------------------------------

# Define default command.
ADD cmd.sh /cmd.sh
RUN chmod +x /cmd.sh

# Define mountable directories.
VOLUME ["/etc/mysql", "/var/lib/mysql"]


# Define working directory.
WORKDIR /

EXPOSE 8080 3306

CMD ["/cmd.sh"]





