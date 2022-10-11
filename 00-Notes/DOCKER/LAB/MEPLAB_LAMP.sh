#!/bin/bash
# Création des répertoires TMP locaux dans /home/$USER
mkdir -p ~/.docker/www ~/.docker/mysql ~/.docker/scripts ~/.docker/credentials \
~/.docker/config
# Modification des droits d'accès afin que Docker y accède
chmod -R 777 ~/.docker/*/
docker run -v ~/.docker/www:/var/www/html -v ~/.docker/mysql:/var/lib/mysql -p \
80:80 -p 3306:3306 --restart=always lioshi/lamp:php5
docker run -v ~/.docker/www:/var/www/html -v ~/.docker/mysql:/var/lib/mysql -p 80:80 -p 3306:3306 ubuntu
