#!/bin/bash
#
# ajout_suppr_apt.sh
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
JAUNE="\\033[1;33m"
ROUGE="\\033[1;31m"

[ $USER != "root" ]
if [ $? = "0" ]
			then
			    echo -e "Pour exécuter ce script il faut être l'utilisateur root !"
			else
					read -p "Mise en place des dépots O/n :" valid
						if [ $valid = "o" ]
							then
								cp /etc/apt/sources.list /etc/apt/sources.list_old
								cp $CUR_DIR/sources.list_install /etc/apt/sources.list
								apt-get update
								apt-get install medibuntu-keyring
								apt-get update
								add-apt-repository ppa:libreoffice/ppa
								apt-get update
							else
								exit 0
						fi

			# https://www.virtualbox.org/wiki/Download_Old_Builds_4_1
					read -p "Installation de virtualBox et des extensions O/n :" virtual
						if [ $virtual = "o" ]
							then
								echo "deb http://download.virtualbox.org/virtualbox/debian `lsb_release -sc` contrib" | sudo tee -a /etc/apt/sources.list
								apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 98AB5139
								apt-get update
								apt-get install virtualbox-4.1
								cd /tmp
								wget http://download.virtualbox.org/virtualbox/4.1.12/Oracle_VM_VirtualBox_Extension_Pack-4.1.12-77245.vbox-extpack
								VBoxManage extpack install Oracle_VM_VirtualBox_Extension_Pack-*.vbox-extpack
								#	rm Oracle_VM_VirtualBox_Extension_Pack-*.vbox-extpack
						fi	
							 read -p "Nom utilisateur VirtualBox à autoriser : " username
								 if [ $username != "" ]
										then
											usermod -G disk -a $username
									  else
										echo "Le nom d'utilisateur est vide. Recommencez !"
								 fi

					read -p "Suppression d'applications : Conserver les fichiers de configuration ? o/N :" valid
						if [ $valid = "o" ]
				  		then
						  	# Supprimer les paquets inutiles (Conserver les fichiers de configuration)
						  	DEL_PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/dell_appli_1004)
								apt-get -y autoremove $DEL_PACKAGES
							else
							  # Supprimer les paquets inutiles (Supprimer les fichiers de configuration)
							  DEL_PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/dell_appli_1004)
								apt-get -y autoremove --purge $DEL_PACKAGES
						fi

					read -p "Pendant l'installation des confirmations vous seront demandées. Ne vous éloignez pas : Continuer ? O/n :" valid
						if [ $valid = "o" ] ;
				  		then
							 # Ajouter les paquets nécessaires
							 PACKAGES=$(egrep -v '(^\#)|(^\s+$)' $CUR_DIR/add_appli_1004)
							 apt-get update && apt-get -y install $PACKAGES
						fi

					read -p ""$JAUNE" Voulez-vous installer les effets de bureau Compiz (3D)? O/n :" compiz
						if [ $compiz = "o" ] ;
					 		then
							  # Installer le gestionnaire de configuration CompizConfig
								apt-get -y install compizconfig-settings-manager
						fi
fi
exit 0
