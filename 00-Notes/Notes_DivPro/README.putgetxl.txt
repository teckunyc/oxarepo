====== Outils put/get XL ======

  * liste des outils disponibles
    * getxl : récupération des fichiers tableur situés dans /home/admin/incoming d'un serveur POM du réseau local
    * getdistxl : récupération des fichiers tableur situés dans /home/admin/incoming d'un serveur POM du réseau distant (accessible via acc@na)
    * putxl : transfert d'un fichier vers /home/admin/incoming d'un serveur POM du réseau local
    * putdistxl : transfert d'un fichier dans /home/admin/incoming d'un serveur POM du réseau distant (accessible via acc@na)
    * webdist : ouverture d'un tunnel https vers un serveur POM du réseau distant (accessible via acc@na)

  * les outils sont positionnés dans le répertoire $HOME/bin
    * la variable d'environnement PATH doit contenir $HOME/bin

  * Organisation
    * on crée un répertoire par client
    * dans chaque répertoire on place un fichier srv.info basé sur $HOME/srv.info.sample
    * se placer obligatoirement dans le répertoire du client pour lancer les commandes get*, put* ou webdist

