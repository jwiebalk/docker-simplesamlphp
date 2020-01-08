#
# VERSION               1.0.0

FROM      alpine:latest
MAINTAINER John Wiebalk "jwiebalk@github.com"

ENV DEBIAN_FRONTEND noninteractive

####################
# apache2 server

RUN apk add --no-cache git curl apache2 openssl libmcrypt php7 php7-mcrypt php7-pear php7-common \
php7-cli php7-curl php7-gmp php7-ldap php7-sqlite3 php7-apache2 php7-iconv \
php7-json php7-openssl php7-phar php7-zlib php7-dom php7-pdo_sqlite apache2-ssl \
php7-xmlwriter php7-simplexml php7-mbstring php7-ctype php7-tokenizer


####################
# SimpleSaml

RUN rm -rf /var/simplesamlphp
RUN git clone https://github.com/simplesamlphp/simplesamlphp.git /var/simplesamlphp

RUN mkdir -p /var/simplesamlphp/config && cp -r /var/simplesamlphp/config-templates/* /var/simplesamlphp/config/
RUN mkdir -p /var/simplesamlphp/metadata && cp -r /var/simplesamlphp/metadata-templates/* /var/simplesamlphp/metadata/

ADD ./etc/simplesamlphp/config/config.php /var/simplesamlphp/config/config.php
ADD ./etc/apache2/conf.d/000-default.conf /etc/apache2/conf.d/000-default.conf

####################
# PKI
RUN mkdir -p /var/simplesamlphp/cert && openssl req -x509 -batch -nodes -newkey rsa:2048 -days 3652 -keyout /var/simplesamlphp/cert/saml.pem -out /var/simplesamlphp/cert/saml.crt

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
