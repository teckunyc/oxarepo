parce que les logs de squid utilise le timestamp unix (12324343323232)
et que moi je lis mieux les timestamps humains (Wed 29 Jul 2015 15h59)

j'ai fais deux petits scripts pour remplacer cat et tail quand on 
travaille avec le fichier access.log de squid.

à utiliser comme vous utiliseriez 'tail -f' et cat

./squid-tail.sh /var/log/squid/access.log | grep "un motif"
ou
./squid-cat.sh /var/log/squid/access.log | grep "un autre motif"


-- 
--
Johann GORLIER
Technical Support Engineer
Tel : +33 (0)1 30 67 60 65
Fax : +33 (0)1 75 43 40 70
POM Monitoring, Solutions d’Intelligence Opérationnelle
Visitez notre site web ! www.pom-monitoring.com
Suivez-nous ! twitter | linkedin | google+

