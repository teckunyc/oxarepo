#!/bin/bash

# 195.130.222.69
# TCP=(443,1863,6022,6070,7000,7070-7150,8443,8080,9000-9030,11110,1195,6082)
# UDP=(5781,1195 )
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 443  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 1863  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 6022  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 6070  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 7000  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 7070-7150  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 8443  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 8080  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 9000:9030  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 11110  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 1195  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p tcp --dport 6082  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p udp --dport 5781  --sport 1024:65534-j ACCEPT
sudo iptables -t filter -A INPUT -s 0.0.0.0 -d 195.130.222.69 -p udp --dport 1195  --sport 1024:65534-j ACCEPT
