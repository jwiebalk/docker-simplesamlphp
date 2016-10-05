# simpleSAMLphp
#
# VERSION               1.0.0

FROM      alpine:3.4
MAINTAINER John Wiebalk "jwiebalk@github.com"

ENV DEBIAN_FRONTEND noninteractive

####################
# apache2 server

RUN apk add --no-cache git curl htop apache2 openssl libmcrypt php5 php5-mcrypt php5-pear php5-common \
php5-cli php5-curl php5-gmp php5-ldap php5-sqlite3 php5-apache2 php5-json php5-openssl php5-phar php5-zlib php5-dom php5-pdo_sqlite


####################
# SimpleSaml

RUN rm -rf /var/simplesamlphp
RUN git clone https://github.com/simplesamlphp/simplesamlphp.git /var/simplesamlphp

RUN mkdir -p /var/simplesamlphp/config && cp -r /var/simplesamlphp/config-templates/* /var/simplesamlphp/config/
RUN mkdir -p /var/simplesamlphp/metadata && cp -r /var/simplesamlphp/metadata-templates/* /var/simplesamlphp/metadata/

ADD ./etc/simplesamlphp/config/config.php /var/simplesamlphp/config/config.php
ADD ./etc/apache2/sites-enabled/000-default.conf /etc/apache2/conf.d/000-default.conf

####################
# PKI
RUN mkdir -p /var/simplesamlphp/cert && openssl req -x509 -batch -nodes -newkey rsa:2048 -keyout /var/simplesamlphp/cert/saml.pem -out /var/simplesamlphp/cert/saml.crt

####################
# Composer

WORKDIR /var/simplesamlphp
RUN curl -sS https://getcomposer.org/installer | php
RUN php composer.phar install

####################
# Final bits
RUN mkdir -p /run/apache2
RUN mkdir -p /var/www/html/

EXPOSE 80
EXPOSE 443

#ENTRYPOINT ["httpd -D FOREGROUND"]
CMD ["httpd","-D","FOREGROUND"]
