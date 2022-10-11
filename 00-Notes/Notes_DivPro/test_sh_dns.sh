#!/bin/bash
        REPS=/var/named/db/
        REPD=/tmp/
        FILE=/var/named/db/exosec.local
        SFILE=/tmp/chk_cname-exosec.tmp
		ALIAS=/tmp/chk_alias-exosec.tmp
		IPFILE=/tmp/chk_ip_cname-exosec.tmp
		PFILE=/tmp/chk_ping_cname-exosec.tmp
		
# Selection des entrées présentes pour les CNAME du fichier exosec.local
# Affiche les cname du domaine.

	grep -i CNAME $FILE | awk '{print $1,$3}' | tee $SFILE
	cat $SFILE | awk '{print $1}' | sort |tee $ALIAS

## boucle de ping

	for i in $(cat $ALIAS)
		do
		ping -c2 $i
		
		echo $i $? | tee -a $PFILE
	done
