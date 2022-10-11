Disk Full

Le disque du serveur POM peut se retrouver saturé (espace occupé à 100%); il en résulte des comportements sporadiques et des problèmes de connexions utilisateurs.

L'une des première chose à vérifier est ce point. L'espace Disque!

Vérifier le taux d'occupation du système:

# df -kTh

Exemple:

[root@srv-pom ~]# df -kTh
Filesystem           Type   Size  Used Avail Use% Mounted on
/dev/cciss/c0d0p1    ext4   7.8G  2.5G  4.9G  34% /
tmpfs                tmpfs  938M     0  938M   0% /dev/shm
/dev/mapper/data-full
                     ext4    49G   30G   17G  64% /data
/dev/cciss/c0d0p3    ext4   2.0G  766M  1.1G  42% /var
/dev/cciss/c0d0p2    ext4   7.8G  1.5G  6.0G  20% /var/backup
tmpfs                tmpfs  128M  640K  128M   1% /var/nagios/checkresults

Si /var/ se retrouve à 100%, les soucis fonctionnels s’enchaîneront.

La procédure consiste à libérer de l'espace disque, en déplaçant certains fichiers de log, notamment le fichier “messages” et ses archives contenus dans /var/log/.

Se déplacer dans le répertoire concerné:

# cd /var/log
# service syslog-ng stop # stopper momentanément les logs
# cp messages-201* /data/log/messages/archives/ # copier les archives dans le répertoire (le créer si besoin)
# cp messages /data/log/messages/ # copier le fichier concerné

Créer un lien symbolique de /var/log/messages vers /data/log/messages, afin que la journalisation se fasse.

# ln -s /data/log/messages/messages /var/log/messages

Il faut à présent modifier le job de logrotate, pour lui indiquer, où se trouvera à présent le fichier de journalisation “message”.

# cd /etc/logrotate.d/ 
# vi syslog

Le contenu par défaut de syslog:

/var/log/messages {
  sharedscripts
  postrotate
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  endscript
}

Le même, avec les nouvelles dispositions

/data/log/messages/messages {
  sharedscripts
  postrotate
    /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
  endscript
}

S'assurer qu'il n'y aura pas de soucis:

# cd /etc/logrotate.d/
# logrotate -d /etc/logrotate.conf 

Si pas de messages d'erreur, relancer le service

# service syslog-ng start


