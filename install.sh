#!/bin/sh

# Dans le terminal  la premiere fois taper :
# chmod +x install.sh
# puis glisser install.sh dans le terminal et valider.

clear

echo "***************************************"
echo "Gestion des utilisateurs par fichiers."
echo "***************************************"

echo "\nVérification des commandes.\n"

# Ou sommes nous ?
repertoire=${0%/*}

echo "Commandes disponibles : "
for c in $(find $repertoire/commandes/*); do
	commande=${c##*/}
	commande=${commande/.sh/}
	echo "- $commande"

	# La commande est-elle installée ?
	echo "Ajouter la commande $commande à votre profil dans le terminal en copiant dans le fichier $HOME/.bash_profile."
	echo "alias dedup=\"$repertoire/commandes/dedup.sh\""
	echo "Passer en mode édition en tapant i puis esc :wq pour sauvegarder"
	echo "vim $HOME/.bash_profile\n"

	echo "Relancer le terminal"
	echo ". $HOME/.bash_profile\n"
	# . $HOME/.bash_profile

	echo "Usage : "
	echo "$commande fichier1.txt fichier2.txt"

done

echo "\n- Installation OK."
echo "\n\n"


