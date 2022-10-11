Votre partition /DATA de 20Giga est trop petite. Il faut l'augmenter.
La machine est-elle une VM ? si oui, il faut agrandir le disque via notre procédure :

Pour étendre la partition data, après ajout d'un disque ou agrandissement d'un disque virtuel.
Dans le cas d'un disque ajouté /dev/sdb ou /dev/sda dans le cas d'un disque virtuel agrandi.
- lancer la commande cfdisk /dev/sdb et créer une partition primaire de type linux
- On initialise /dev/sdb1 en vue de son utilisation dans LVM
[root@MAPOM ~]# pvcreate /dev/sdb1
Physical volume "/dev/sdb1" successfully created
(en cas d'erreur il faut forcer sa détection avec la commande partx -v -a /dev/sdb et relancer pvcreate)
- Récupérer le nom et le path du volume logique
[root@MAPOM ~]# lvdisplay
--- Logical volume ---
LV Path /dev/data/full
LV Name full
VG Name data
LV UUID fczMYJ-XSjf-quv1-Ka5U-IyB6-n6YI-vcMNvL
LV Write Access read/write
LV Creation host, time localhost.localdomain, 2015-06-20 21:23:52 +0200
LV Status available # open 1
LV Size 29.59 GiB
Current LE 947
Segments 1
Allocation inherit
Read ahead sectors auto
- currently set to 256
Block device 253:0
- Ajouter /dev/sdb1 au groupe de volume data
[root@MAPOM ~]# vgextend data /dev/sdb1
Volume group "data" successfully extended
- Récupérer le nombre de PE (physical extend) disponibles : FREE PE (ici 384)
[root@MAPOM ~]# pvdisplay
--- Physical volume ---
PV Name /dev/sda7
VG Name data
PV Size 29.62 GiB / not usable 22.00 MiB
Allocatable yes (but full)
PE Size 32.00 MiB
Total PE 947
Free PE 0
Allocated PE 947
PV UUID 8iXM9p-Oize-Rjxv-lOOc-CKZh-LKIJ-8U7qtD
--- Physical volume ---
PV Name /dev/sdb1
VG Name data
PV Size 12.02 GiB / not usable 18.33 MiB
Allocatable yes
PE Size 32.00 MiB
Total PE 384
Free PE 384
Allocated PE 0
PV UUID KMt2CU-Sjkq-Z0gx-vMcQ-mezw-mBaA-KC7Tyn
- Augmenter la taille du volume logique
[root@MAPOM ~]# lvresize -l +384 /dev/data/full
Size of logical volume data/full changed from 29.59 GiB (947 extents) to 41.59 GiB (1331 extents).
Logical volume full successfully resized
- Avant de redimensionner le système de fichier, arrêter tous les services susceptibles d'écrire dans /data
[root@MAPOM ~]# service perf2rrd stop
Stopping perf2rrd: [ OK ]
[root@MAPOM ~]# service nagios stop
nagios is stopped
[root@MAPOM ~]# service mysqld stop
Stopping mysqld: [ OK ]
[root@MAPOM ~]# service ndoutils stop
Stopping ndo2db: [ OK ]
[root@MAPOM ~]# service syslog-ng stop
Stopping syslog-ng: [ OK ]
[root@MAPOM ~]# service snmptrapd stop
Stopping snmptrapd: [ OK ]
[root@MAPOM ~]# service postgresql-9.1 stop
Stopping postgresql-9.1 service: [ OK ]
- redimensionner le système de fichier (cette étape peut prendre quelques minutes en fonction de la taille)
[root@MAPOM ~]# resize2fs /dev/mapper/data-full
resize2fs 1.41.12 (17-May-2010)
Filesystem at /dev/mapper/data-full is mounted on /data; on-line resizing required
old desc_blocks = 2, new_desc_blocks = 3
Performing an on-line resize of /dev/mapper/data-full to 10903552 (4k) blocks.
The filesystem on /dev/mapper/data-full is now 10903552 blocks long.
- Vérifier
[root@MAPOM ~]# df -H
Filesystem Size Used Avail Use% Mounted on
/dev/sda2 8.4G 1.7G 6.3G 21% /
tmpfs 258M 0 258M 0% /dev/shm
/dev/sda1 252M 49M 190M 21% /boot
/dev/mapper/data-full
44G 453M 42G 2% /data
/dev/sda5 4.1G 164M 3.8G 5% /var
/dev/sda3 8.4G 85M 7.9G 2% /var/backup
tmpfs 135M 0 135M 0% /var/nagios/checkresults
- Relancer les services
[root@MAPOM ~]# service postgresql-9.1 start
Starting postgresql-9.1 service: [ OK ]
[root@MAPOM ~]# service snmptrapd start
Starting snmptrapd: [ OK ]
[root@MAPOM ~]# service syslog-ng start
Starting syslog-ng: [ OK ]
[root@MAPOM ~]# service ndoutils start
Starting ndo2db: [ OK ]
[root@MAPOM ~]# service mysqld start
Starting mysqld: [ OK ]
[root@MAPOM ~]# service nagios start
nagios is stopped
Cleanup nagios checkresults: [ OK ]
Starting nagios: [ OK ]
[root@MAPOM ~]# service perf2rrd start
Starting perf2rrd: [ OK ]

