# Use an offical ubuntu image
FROM ubuntu:16.04
MAINTAINER Linhao Yu

# Set the working directory to /script
WORKDIR /www

# Copy the current directory contents into the container at /script
#ADD . /script

RUN apt-get update && apt-get install -y \
	apache2 \
	php \
	libapache2-mod-php \
	php-mcrypt \
	php-mysql \
	&& \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

RUN service apache2 restart

# for http
EXPOSE 80

# for MySql server
EXPOSE 3306
