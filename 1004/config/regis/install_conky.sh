#!/bin/bash

# Mettre en place Conky

[ $USER != "root" ]
if [ $? = "0" ]
				 then
		        echo "Pour exécuter ce script il faut être l'utilisateur root !"
				 else
read -p 'Utilisteur qui veut installer Conky ? :' nom
	if [ $nom != "" ]
				then
								cp /usr/share/ubuntu1004/1004/config/regis/codage_conky	/home/$nom/.conkyrc
								chown $nom:$nom /home/$nom/.conkyrc
				else
							echo -p "Le nom de l'utilisateur doit être indiqué. Recommencez"
	fi
fi
exit 0
