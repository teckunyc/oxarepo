# blank.sh
tcpdump -vnni any port 161 -G 1800 -W 1 -w /tmp/exosec%H%M%S_mkl.pcap.cap


SRC=10.20.65.190 DST=10.20.64.31 DPT=161

netstat -a | select-string "LISTEN" qui va lister les ports ouverts en ecoute (LISTEN)
netstat -ab qui listera alors tous les ports ouverts ET l'executable qui a ouvert ce port (mais aussi toutes les connexions actives, donc la liste peut etre longue)
