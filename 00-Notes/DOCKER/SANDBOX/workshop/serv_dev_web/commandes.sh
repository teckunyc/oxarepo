# Run weblab avec montage sur partition locale
docker run -d --name pom_beta -v /mnt/docker/shares/web/html/:/var/www/html -p 8081:80 nickistre/ubuntu-lamp supervisord

# dockerized
mysql -u root -p -h localhost
mysql> create DATABASE jooBase01;
mysql> exit;
mysql -u root -p -h localhost </var/www/html/wiki/jooBase01.sql
# nb: le point de montage contient un tar de /var/lib/mysql du container lamp
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '&é"''"é&' WITH GRANT OPTION;
FLUSH PRIVILEGES;
QUIT;
