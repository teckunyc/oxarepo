Suffixer les sauvegardes ou manipulation de fichier:
DATE=$(date +%Y%m%d-%H%M)
# $(date +%Y%m%d-%H%M)

Relance des services POM

# /etc/init.d/mysqld restart
# /etc/init.d/ndoutils restart
# /etc/init.d/syslog-ng restart
# Vérifier la configuration du nagios et le relancer
# nagios -v /etc/nagios/nagios.cfg
# /etc/init.d/nagios restart


Synchroniser une pomHA (depuis le master)
# pomha sync push -f


 sudo squid -k reconfigure



 tar c /home/mike/temp/home/admin/incoming -c plan-ip.xls | ssh cmd@na pom.xxxx "tar xv -C /home/admin/incoming/"

