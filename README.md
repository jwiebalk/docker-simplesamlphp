# docker-simplesamlphp

simpleSAMLphp server hosted in Docker.


## Prerequisites

Docker

## Installation

Clone repo to get demo config data and update `saml20-sp-remote.php` to point to your GHE deployment

```
git clone https://github.com/jwiebalk/docker-simplesamlphp.git
cd docker-simplesamlphp
```

## Prerequisites

  - Install [Docker](https://www.docker.com/)

## Install from DockerHub

Rather than build it yourself, the full container is available on [DockerHub](https://hub.docker.com/r/jwiebalk/simplesamlphp/)

```
sudo docker pull jwiebalk/simplesamlphp
sudo docker run -d -p 8080:80 -p 8444:443 jwiebalk/simplesamlphp
```

To access simpleSAMLphp from the host server:

```
http://localhost:8080/simplesaml/

username: admin
password: password

```

To use your own/example configs stored on the host in /var/simplesamlphp

```
sudo docker run -d -p 8080:80 -p 8444:443 \
-v /GitHub/docker-simplesamlphp/etc/simplesamlphp/config/:/var/simplesamlphp/config/ -v /GitHub/docker-simplesamlphp/etc/simplesamlphp/metadata/:/var/simplesamlphp/metadata/ jwiebalk/simplesamlphp
```

## Build the Package and Publish it to Dockerhub

Build the container locally

```
git clone https://ghe.io/jwiebalk/docker-simplesamlphp.git
cd docker-simplesamlphp
sudo docker build --rm=true -t simplesamlphp .
```

### Adding ServiceProvider notes

For the `saml20-sp-remote.php` file this can be created using the [XML to SimpleSAMLphp metadata converter](https://localhost:8444/simplesaml/module.php/core/frontpage_federation.php)
and pasting in the metadata from your SP such as `https://{ghe-instance}/saml/metadata`
