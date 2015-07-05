#!/bin/bash
#
# configurer-console.sh
# Récupérer la valeur d'une commande dans une variable :
# var=$(commande)
# Récupération de la sortie standard
#     * stdout uniquement
#           o var=$(commande) 
#     * stdout et stderr
#           o var=$(commande 2>&1) 
#     * Récupération du code retour ($?)
#           o Code retour seul
#                 + commande
#                 + var=$? 
#           o Les deux
#                 + var=$(commande)
#                 + var=$?
# Print Working Directory

CUR_DIR=$(pwd)
read -p "Suppression d'applications. Conserver les fichiers de configuration ? o/n :" valid
if [ $valid = "o" ]
	then
	# Supprimer les paquets inutiles (Conserver les fichiers de configuration)
	DEL_PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/del_appli_ub.1004)
	apt-get -y autoremove $DEL_PACKAGES
else
	# Supprimer les paquets inutiles (Supprimer les fichiers de configuration)
	DEL_PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/del_appli_ub.1004)
	apt-get -y autoremove --purge $DEL_PACKAGES
fi
