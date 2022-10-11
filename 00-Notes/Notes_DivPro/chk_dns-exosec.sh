#!/bin/bash
        REPS=/var/named/db/
        REPD=/tmp/
        FILE=/var/named/db/10.IN-ADDR.ARPA
        SFILE=/tmp/chk_ptr-exosec.tmp
		IPFILE=/tmp/chk_ip-exosec.tmp
		PFILE=/tmp/chk_ping-exosec.tmp
		
# Selection des entrées présentes pour les PTR du fichier 10.IN-ADDR.ARPA.
# Affiche la quantité de FQDN (meme nom pour plusieurs réseaux) et ses IP.
# Le résultat est expédié dans le fichier /tmp/chk_ptr...($SFILE)
	grep -i PTR $FILE | awk '{print $3"--> "$1}' | sed -e 's#\.$ ##g' | sort | uniq -c | tee $SFILE
###### Sortie obtenue #####
##     1 w2k-coss.exosec.local.--> 9.3
##     1 wks-aluminium.exosec.local.--> 7
##     1 wxp-coss.exosec.local.--> 15.3
##     1 yttrium.exosec.local.--> 39
##     1 zimbra.exosec.local.--> 24
	awk '{print $3}' $FILE | sed -e 's#\.$##g' | sort -u | tee $IPFILE

	for i in $(cat $IPFILE)
		do
		ping -c2 $i
		
		echo $? | tee -a $PFILE
	done

        
