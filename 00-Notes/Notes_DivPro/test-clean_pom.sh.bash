#!/bin/bash
############################################
#SCRIPT_CLEAN_POM_LOG
##/home/admin/exosec/tools
###Version:001.0-20151024.MKL
############################################
# Informations
# mkdir -p /tmp/logArchives && cp -aR /var/log/ /tmp/logArchives && gunzip -drf /tmp/logArchives/*.gz
echo """SCRIPT_CLEAN_POM_LOG"""

## Déclaration des variables utilisées"
                SRCLOG='/var/log/'
                DSTLOG='/mnt/backup/logArchives'
                TAMP='/tmp/exosec.tmp'
                RTMP='/tmp/logArchives'
                DATE=$(date +%Y%m%d)
                
# création du repertoire temporaire (test)
sudo mkdir -p $RTMP

# MENU 1
# Déplacement du prompt par sécurité
###cd $SRCLOG
# s'assurer de l'intéraction utilisateur
boollist="0";
#menu
while [ "$choix" != "5" ]; do
    clear #clear du terminal
    echo """----------------------------------------------------"""
    echo """        1. Rechercher les archives antérieurs à"""
    echo """        2. _ACTION-BOUCLE_02"""
    echo """        3. _ACTION-BOUCLE_03"""
    echo """        4. _ACTION-BOUCLE_04"""
    echo """        5. Quitter"""
    echo """----------------------------------------------------"""
    echo -en """\nVotre choix : """
    read choix
########################################################################
### CHOIX 1        Rechercher des vieilles archives
########################################################################
## Choix de la période à couvrir (3,30,60,90,180,365) en jours
### Boucle pointant vers rep tempory pour essais
cd $RTMP 	#(test)
# Sous menu de CHOIX 1        
# Choix de la période et purge du tampon
#-----------------------------------------------------------------------
    if [ "$choix" = "1" ] ; then
                while [ "$time" != "8" ]; do
                        echo """""" | tee $TAMP
                        echo """----------------------------------------------------"""
                        echo """Sélectionner les archives antérieurs à"""
                        echo """        1. 3 jours"""
                        echo """        2. 30 jours"""            
                        echo """        3. 60 jours"""            
                        echo """        4. 90 jours"""
                        echo """        5. 180 jours"""
                        echo """        6. 365 jours"""
                        echo """        7. Afficher les fichiers qui sont sélectionnés"""            
                        echo """        8. Menu précédent"""
                        echo """----------------------------------------------------"""
                        echo -en """\nVotre choix : """
                        read time
                        
# Action selon période
#choix1 période 3 jours
                                if [ "$time" = "1" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +3 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +3 -type f -name '*\.[0-9]')
                      clear
                                        fi
#choix2 période 30 jours
                                if [ "$time" = "2" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +30 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +30 -type f -name '*\.[0-9]')
                      clear
                                        fi
#choix3 période 60 jours
                                if [ "$time" = "3" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +60 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +60 -type f -name '*\.[0-9]')
                      clear
                                        fi
#choix4 période 90 jours
                                if [ "$time" = "4" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +90 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +90 -type f -name '*\.[0-9]')
                      clear
                                        fi
#choix5 période 180 jours
                                if [ "$time" = "5" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +180 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +180 -type f -name '*\.[0-9]')
                      clear
                                        fi
#choix6 période 365 jours
                                if [ "$time" = "6" ] ; then
                      afiles=$(find $RTMP -maxdepth 8 -mtime +365 -type f -regextype posix-egrep -regex '.*\.(gz|log)$')
                      bfiles=$(find $RTMP -maxdepth 8 -mtime +365 -type f -name '*\.[0-9]')
                      clear
                                        fi        

#choix7 Afficher le fichier tampon $TAMP
                                if [ "$time" = "7" ] ; then
                      clear
                      cat $TAMP
                                        fi                                                                                                                                                        
                                        
                                if [ "$afiles" = "" ] ||  [ "$bfiles" = "" ] ; then
            echo """----------------------------------------------------"""
            echo """Aucun fichier correspondant. Faites un autre choix        """
            echo """----------------------------------------------------"""
                                        else
            echo """----------------------------------------------------"""
            echo """ Fichiers correspondants à la période                   """
            echo """----------------------------------------------------"""
            ls $afiles | sort -n| tee $TAMP
            ls $bfiles | sort -n| tee -a $TAMP
            cat $TAMP | sort -n | wc -l
                       fi
							echo """----------------------------------------------------"""
							echo """Le scan est effectué, les fichiers sélectionnés sont stockés dans"""  $TAMP
							echo """Ctrl+C pour stopper l'exécution du script"""            
					done
# Fin du menu 1 sélectionner les archives antérieurs à X jours
#-------------------------------------------------------------------------
########################################################################
### CHOIX 2        Création des répertoires et stockage
########################################################################
        boollist="1"
  fi
    if [ "$choix" = "2" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n """Création des répertoires"""
            for unfic in $afiles; do
                >$unfic
            done
            if [ "$choix" != "4" ] ;then boollist="0" ;fi
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi
  
    #on supprime les anciens logs
    if [ "$choix" = "3" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n "Suppression des vieux logs... "
            for unfic in $vfiles; do
              #  rm -Rf $unfic
              ls -l $unfic
            done
            boollist="0"
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi

done
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
########################################################################
### CHOIX 3			XXXXX
########################################################################
        boollist="1"
  fi
    if [ "$choix" = "2" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n """Création des répertoires"""
            for unfic in $afiles; do
                >$unfic
            done
            if [ "$choix" != "4" ] ;then boollist="0" ;fi
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi
  
    #on supprime les anciens logs
    if [ "$choix" = "3" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n "Suppression des vieux logs... "
            for unfic in $vfiles; do
              #  rm -Rf $unfic
              ls -l $unfic
            done
            boollist="0"
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi

done
#-------------------------------------------------------------------------
#-------------------------------------------------------------------------
########################################################################
### CHOIX 4				XXXXX
########################################################################
        boollist="1"
  fi
    if [ "$choix" = "2" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n """Création des répertoires"""
            for unfic in $afiles; do
                >$unfic
            done
            if [ "$choix" != "4" ] ;then boollist="0" ;fi
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi
  
    #on supprime les anciens logs
    if [ "$choix" = "3" ] || [ "$choix" = "4" ] ; then
        if [ "$boollist" = "1" ] ; then
            echo -n "Suppression des vieux logs... "
            for unfic in $vfiles; do
              #  rm -Rf $unfic
              ls -l $unfic
            done
            boollist="0"
            echo "OK"
        else
            echo """Opération non-réalisée, aucun fichier sélectionné"""
        fi
    fi

done
#-------------------------------------------------------------------------

#-------------------------------------------------------------------------
# terminer le processus avec status OK
exit 0
