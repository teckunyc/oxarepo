#!/bin/bash
#   MAINTAINER Oxatek <oxatek42@gmail.com>
#   Organisation/personne: Mike Langlet
#   blank.sh


# le serveur mysql n'est pas lancé
service mysql start && service apache2 restart
