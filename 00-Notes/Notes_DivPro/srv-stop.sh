#!/bin/bash
## stop srv
sudo service apache stop 
sudo service mysql stop 
sudo service webmin stop 
echo "SRV Stopped" && sleep 5
exit 0
