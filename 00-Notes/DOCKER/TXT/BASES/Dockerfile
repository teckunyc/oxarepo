# Image de base (sur laquelle run les containers)
FROM debian:latest

# Organisation/personne qui maintient le Dockerfile
MAINTAINER Oxatek <oxatek42@gmail.com>

RUN apt-get update && RUN apt-get -y install wget openssh-server curl tcpdump nmap apache

# RUN apt-get -y install curl

# ADD /SRC/foo/script /DST/foo/script
# RUN chmod +x /DST/foo/script
ENTRYPOINT
EXPOSE 80
CMD ["script.sh"]

