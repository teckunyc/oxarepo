#!/bin/bash
## Start srv
sudo service apache2 restart 
sudo service mysql restart 
sudo service webmin restart 
echo "SRV Started" sleep 5
exit 0
