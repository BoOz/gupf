#!/bin/sh

# Dans le terminal  la premiere fois taper :
# chmod +x install.sh
# puis glisser install.sh dans le terminal et valider.

clear

# Ou sommes-nous ?
repertoire=${0%/*}

echo "***************************************"
echo "Commandes en plus dans le terminal"
echo "***************************************"

echo "\nVérification des commandes.\n"

echo "Commandes disponibles : "
find $repertoire/commandes/* | while read c
do
	f=$(realpath $c)
	commande=${c##*/}
	commande=${commande/.sh/}
	echo "- $commande"

	# La commande est-elle installée ?
	echo "Ajouter la commande \`$commande\` dans le fichier \`$HOME/.bash_profile\`."
	echo "vim $HOME/.bash_profile # dans une nouvelle fenêtre du terminal.\n"
	echo "Taper \`i\` et copier la ligne ci-dessous :"
	echo "alias $commande=\"$f\""
	echo "Taper \`esc :wq\` pour sauvegarder."
	
	echo "Relancer le terminal"
	echo ". $HOME/.bash_profile\n"
	# . $HOME/.bash_profile

	echo "Usage : $commande help\n\n"

done

echo "\n- Installation OK."
echo "\n\n"


