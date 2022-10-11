#!/bin/bash
# On liste nos bases de données
LISTEBDD=$( echo 'show databases' | mysql -u backup --password=< mot de passe >)
    for BDD in $LISTEBDD;  do
# Exclusion des BDD information_schema , mysql et Database
      if [[ $BDD != "information_schema" ]] && [[ $BDD != "mysql" ]] && [[ $BDD != "Database" ]]; then
# Emplacement du dossier ou nous allons stocker les bases de données, un dossier par base de données
CHEMIN=/space/home/$user/save_BD/$BDD
DATE=`date +%y_%m_%d`
# On backup notre base de donnees
      mysqldump -u backup --single-transaction --add-drop-dabatase --password= $BDD > "$CHEMIN/$BDD"_"$DATE.sql"
      echo "|Sauvegarde de la base de donnees $BDD"_"$DATE.sql dans "$CHEMIN" ";
    fi

# On compte le nombre d'archive presente dans le dossier
NbArchive=$(ls -A $CHEMIN/ |wc -l)
# Si il y a plus de 4 archives, on supprime la plus ancienne
      if [ "$NbArchive" -gt 4 ];then
# On recupere l'archive la plus ancienne
Old_backup=$(ls -lrt $CHEMIN/ |grep ".sql" | head -n 1 | cut -d ":" -f 2 | cut -d " " -f 2);
# On supprime l'archive la plus ancienne
      rm $CHEMIN/$Old_backup
    fi
done
