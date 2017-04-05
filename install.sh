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

echo "Installation et mise à jour"
echo "Ajouter les commandes \`terminal\` dans le fichier \`$HOME/.bash_profile\`."
echo "vim $HOME/.bash_profile # dans une nouvelle fenêtre du terminal.\n"
echo "Taper \`i\` et copier les lignes ci-dessous puis taper \`esc :wq\` pour sauvegarder."

echo "Relancer le terminal"
echo ". $HOME/.bash_profile\n"

echo "\nCommandes à copier-coller dans le fichier \`.bash_profile\` \n"

echo "# Config terminal ++\n"
echo "# terminal"
echo "alias terminal=\"cd /Users/vincent/Sites/github/terminal ; git pull ; ./install.sh\""
echo "# Usage : terminal\n"
find $repertoire/commandes/* | while read c
do
	f=$(realpath $c)
	commande=${c##*/}
	commande=${commande/.sh/}
	echo "# $commande"

	# La commande est-elle installée ?
	echo "alias $commande=\"$f\""
	echo "# Usage : $commande help\n"

done

echo "\n- Installation OK."
echo "\n\n"


