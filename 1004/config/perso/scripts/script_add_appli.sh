#!/bin/bash

CUR_DIR=$(pwd)
read -p "Pendant l'installation des confirmations vous seront demandées. Continuer ? o/n :" valid
if [ $valid = "o" ] ;
	then
	# Ajouter les paquets nécessaires
	PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/add_appli_ub.1004)
	apt-get update && apt-get -y install $PACKAGES
fi

read -p "Voulez-vous installer les effets de bureau Compiz (3D) ? o/n :" compiz
if [ $compiz = "o" ] ;
	then
	# Installer le gestionnaire de configuration CompizConfig
	apt-get -y install compizconfig-settings-manager
fi
