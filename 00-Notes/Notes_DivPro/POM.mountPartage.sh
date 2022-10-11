#!/bin/bash
# On ouvre le port 80 ou http pour la navigation sur Internet
sudo iptables -t filter -A OUTPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 80 -j ACCEPT
