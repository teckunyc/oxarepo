cat log-*.log | grep -v cron.info | grep -v mail.info | grep -v daemon.notice | grep -v syslog.notice | grep -v authpriv.info | grep -v cron.notice

cat /tmp/log-*.log | grep -i cron.info | grep -i mail.info | grep -i daemon.notice | grep -i syslog.notice | grep -i authpriv.info | grep -i cron.notice

Generer passwd password
# pwgen -n -c -y 12 1
# ssh-keygen -t rsa -b 2048
