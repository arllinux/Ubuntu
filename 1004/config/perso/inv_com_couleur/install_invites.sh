#!/bin/bash
# Ce script permet, avec les deux fichiers contenus dans ce même dossier,
# d'installer les invites de commande personnalisée et de paramétrer vim.

# Fichiers :	invite_user
#							invite_root
# Script :	script_install_invites.sh
# Pour lancer ce script il faut se placer dans le dossier qui le contient
# puis ./script_install_invites.sh


# Dernière modifs 4/02/2012 

FILE_U=invite_user
FILE_R=invite_root
RC_USER=/home/
RC_USER2=/.bashrc
RC_ROOT=/root/.bashrc

[ $USER != "root" ]
if [ $? = "0" ]
	then
		echo "Pour exécuter ce script il faut être l'utilisateur root !"
else
		read -p 'Nom Utilisateur (login) à personnaliser : ' nom
	if [ $nom != "" ]
	then

		# Configuration de Vim
		#	cat vimrc.local > /etc/vim/vimrc.local
		#	chmod 0644 /etc/vim/vimrc.local

		# Installation invite perso
			cat "$FILE_U" >> "$RC_USER$nom$RC_USER2"
			chown $nom:$nom "$RC_USER$nom$RC_USER2"
			chmod 0644 "$RC_USER$nom$RC_USER2"

		# Installation pour les futurs utilisateurs
			cat "$FILE_U" > /etc/skel/.bash_aliases
			chown root:root /etc/skel/.bash_aliases
			chmod 0644 /etc/skel/.bash_aliases

		# Installation invite root
			cat "$FILE_R" >> "$RC_ROOT"
			chown root:root "$RC_ROOT"
			chmod 0644 "$RC_ROOT"
			echo "Pour que les modifications soit prises en compte veuillez relancer la console"

	else
		echo "Le nom d'utilisateur est vide. Recommencez !"
	fi
fi
