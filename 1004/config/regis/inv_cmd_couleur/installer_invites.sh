#!/bin/bash
# Ce script permet, avec les deux fichiers contenus dans ce même dossier,
# d'installer les invites de commande personnalisée et de paramétrer vim.

# Fichiers :	invite_user_regis
#							invite_root_regis
# Script :	installer_invites.sh
# Pour lancer ce script il faut se placer dans le dossier qui le contient
# puis ./installer_invites.sh


# Dernière modifs 4/02/2012 

FILE_U=invite_user_regis
FILE_R=invite_root_regis
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
			# Empêcher l'accès en lecture des dosssiers des autres utilisateur (libre
			# par default)
			sed -i 's/\(DIR_MODE=0755\).*/\DIR_MODE=0750/' /etc/adduser.conf

		# Installation invite root
			cat "$FILE_R" >> "$RC_ROOT"
			chown root:root "$RC_ROOT"
			chmod 0644 "$RC_ROOT"
			echo "Pour que les modifications soit prises en compte veuillez relancer la console"

		# mettre en place l'image de fond de grub et les couleurs de texte
			cp /usr/share/ubuntu1004/1004/config/regis/inv_cmd_couleur/ww.tga /boot/grub/ww.tga
			mv /etc/grub.d/05_debian_theme /etc/grub.d/05_debian_theme_old
			cp /usr/share/ubuntu1004/1004/config/regis/inv_cmd_couleur/05_debian_theme /etc/grub.d/05_debian_theme
			update-grub

	else
		echo "Le nom d'utilisateur est vide. Recommencez !"
	fi
fi
