# Use an offical ubuntu image
FROM ubuntu:16.04
MAINTAINER Linhao Yu

# Set the working directory to /script
WORKDIR /www

# Copy the current directory contents into the container at /script
ADD . /www

RUN ["chmod", "+x", "/www/start-servers.sh"]

RUN apt-get update && apt-get install -y \
	apache2 \
	php \
	libapache2-mod-php \
	php-mcrypt \
	php-mysql

# install mysql
ARG ROOT_PASSWORD
RUN echo mysql-server mysql-server/root_password password $ROOT_PASSWORD | debconf-set-selections;\
  echo mysql-server mysql-server/root_password_again password $ROOT_PASSWORD | debconf-set-selections;
RUN apt-get install -y mysql-server

RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

# for http
EXPOSE 80

# for MySql server
EXPOSE 3306

ENTRYPOINT service apache2 start &&  service mysql start && tail -f /dev/null
