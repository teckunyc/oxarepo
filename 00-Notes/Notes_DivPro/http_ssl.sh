#!/bin/sh
############################################
#SCRIPT_SSL_APACHE
##/home/mike/02-mes_scripts/01-system/
###Version 26/05/2008.MKL
############################################
# Déclarations du repertoire Apache.
	rep='/etc/apache2'
	echo "Mise en place des certificats SSL" "$rep"".\nVous devez utilisez les droits administrateur"

## PARTIE I

#--Création des répertoires et des clefs.
#Creation du repertoire ssl.key et la clef RSA

cd $rep && sudo mkdir ssl.key && cd ssl.key

#Generation de la clef RSA
sudo openssl genrsa -out server.key 2048 && sudo chmod 600 server.key

#Creation du repertoire ssl.csr
cd $rep && sudo mkdir ssl.csr && cd ssl.csr

#Generation du certificat du serveur
sudo openssl req -new -key $rep/ssl.key/server.key -out server.csr

#x509 et Auto approbation du certificat
#Creation du repertoire ssl.crt
cd $rep && sudo mkdir ssl.crt && cd ssl.crt

#Generation du certificat
sudo openssl req -new -x509 -nodes -sha1 -days 365 -key $rep/ssl.key/server.key -out server.crt && cd /home/$USER && $SHELL

		###Le systeme va vous demander deux fois consecutivement de renseigner certaines informations
		######Mise en place des certificats SSL /etc/apache2.
		######Vous devez utilisez les droits administrateur
		######Generating RSA private key, 1024 bit long modulus
		######........................................++++++
		######....++++++
		######e is 65537 (0x10001)
		######You are about to be asked to enter information that will be incorporated
		######into your certificate request.
		######What you are about to enter is what is called a Distinguished Name or a DN.
		######There are quite a few fields but you can leave some blank
		######For some fields there will be a default value,
		######If you enter '.', the field will be left blank.
		######-----
		######Country Name (2 letter code) [AU]:FR
		######State or Province Name (full name) [Some-State]:FR
		######Locality Name (eg, city) []:PARIS
		######Organization Name (eg, company) [Internet Widgits Pty Ltd]:MKL
		######Organizational Unit Name (eg, section) []:MKL_ZONE
		######Common Name (eg, YOUR name) []:Mike
		######Email Address []:

		######Please enter the following 'extra' attributes
		######to be sent with your certificate request
		######A challenge password []:
		######An optional company name []:
		######You are about to be asked to enter information that will be incorporated
		######into your certificate request.
		######What you are about to enter is what is called a Distinguished Name or a DN.
		######There are quite a few fields but you can leave some blank
		######For some fields there will be a default value,
		######If you enter '.', the field will be left blank.
		######-----
		######Country Name (2 letter code) [AU]:FR
		######State or Province Name (full name) [Some-State]:FR
		######Locality Name (eg, city) []:PARIS
		######Organization Name (eg, company) [Internet Widgits Pty Ltd]:MKL
		######Organizational Unit Name (eg, section) []:MKL_ZONE
		######Common Name (eg, YOUR name) []:Mike
		######Email Address []:

## PARTIE II

#Il faut à présent informer Apache de la mise en place des certificats

cd /etc/apache2/sites-available && editor default

		#### Et ajouter au VirtualHost concerné (sans les '###'):
		###SSLEngine On
		###SSLCertificateKeyFile /etc/apache2/ssl.key/server.key
		###SSLCertificateFile /etc/apache2/ssl.crt/server.crt
		###SSLCACertificateFile /etc/apache2/ssl.crt/server.crt
		###DocumentRoot /var/www/

#Activer le mod_ssl pour Apache2
sudo a2enmod ssl

#Relancer Apache
sudo /etc/init.d/apache2 restart && firefox https://127.0.0.1



# Le fichier '/etc/apache2/sites-available/default' devrait etre similaire à ce qui suit, mais sans aucun ####

		######NameVirtualHost *:80
		######<VirtualHost *:80>
		######        DocumentRoot /var/www/http
		######</VirtualHost>

		######NameVirtualHost *:443
		######<VirtualHost *:443>
		######	SSLEngine On
		######	SSLCertificateKeyFile /etc/apache2/ssl.key/server.key
		######	SSLCertificateFile /etc/apache2/ssl.crt/server.crt
		######	SSLCACertificateFile /etc/apache2/ssl.crt/server.crt
		######        DocumentRoot /var/www/https
		######</VirtualHost>
