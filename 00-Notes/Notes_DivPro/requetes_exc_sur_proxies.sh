#!/bin/bash
echo "---------------------------------"
echo "Requetes excessives sur proxies XXXX"
echo "adresses des proxys : 192.168.202.20 et 192.168.201.20"
echo "---------------------------------"

         prox1=192.168.201.20
         prox2=192.168.202.20
         fichier1=/var/log/network/10.1.1.3/local/2015-07-23.log
         fichier2=/var/log/network/10.2.1.3/local/2015-07-23.log


grep -i $prox1 $fichier1 | grep -i open | grep -i http | awk '{print $15}' | cut -f2 -d "=" | cut -f1 -d ":" | sort -n | uniq -c | sort -nk 1
grep -i $prox2 $fichier2 | grep -i open | grep -i http | awk '{print $15}' | cut -f2 -d "=" | cut -f1 -d ":" | sort -n | uniq -c | sort -nk 1
