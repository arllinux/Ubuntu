#!/bin/bash
echo "script Nettoyage UBUNTU"
sudo apt-get clean
echo "Cache (/var/cache/apt/archives) Paquets supprimés. OK"
sleep 3
rm -r -f ~/.Trash/*
echo "Suppression de la CORBEILLE  : vide. OK"
sleep 3
find ~/ -name '*~' -exec rm {} \;
echo "Suppression des fichiers temporaires du dossier home terminant par ~. Terminé. OK"
echo "TERMINÉ"
