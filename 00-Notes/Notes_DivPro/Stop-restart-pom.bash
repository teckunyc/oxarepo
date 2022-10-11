#!/bin/bash
## Relancer les services POM
service postgresql-9.1 stop
service snmptrapd stop
service syslog-ng stop
service ndoutils stop
service mysqld stop
service nagios stop
service perf2rrd stop
sleep 3
service postgresql-9.1 start
service snmptrapd start
service syslog-ng start
service ndoutils start
service mysqld start
service nagios start
service perf2rrd start

