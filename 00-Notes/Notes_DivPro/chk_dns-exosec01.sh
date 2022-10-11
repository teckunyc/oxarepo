#!/bin/bash
        DOM=exosec.local
        REPD=/tmp/
        SFILE1=/tmp/hostip.tmp
		HOSTS=/tmp/chk_hosts-exosec.tmp
		PFILE=/tmp/chk_ping-exosec.tmp
		
host -l $DOM | awk '{print $1,$4}' | tee $SFILE1
awk '{print $1}' < $SFILE1 | tee $HOSTS

for i in $(cat $HOSTS)
	do
	ping -c2 $i
	echo $i $? | sort -k2 | tee -a $PFILE
	echo "<-------------------------------->"
done
