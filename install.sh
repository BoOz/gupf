#!/bin/sh

# Dans le terminal  la premiere fois taper :
# chmod +x install.sh
# puis glisser install.sh dans le terminal et valider.

clear

echo "***************************************"
echo "Commandes en plus dans le terminal"
echo "***************************************"

echo "Installation et mise à jour"

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DIR"

# echo "Bienvenue dans $DIR !"

# maj des fichiers
git pull

#. "$HOME/.bash_profile"

command -v realpath >/dev/null 2>&1 || { echo >&2 "\nErreur. Installer coreutils pour faire fonctionner spip_statique. brew install coreutils\n"; exit 1; }


echo "# Ajouter les commandes \`terminal\` dans le fichier \`$HOME/.bash_profile\`."
echo "vim $HOME/.bash_profile # dans une nouvelle fenêtre du terminal.\n"
echo "Taper \`i\`, copier la ligne ci-dessous puis taper \`esc :wq\` pour sauvegarder."

echo '\nexport PATH=$PATH:'$DIR'/bin\n'

[ ! -d "$DIR/bin" ] && mkdir "$DIR/bin"

echo "\nCommandes disponibles \n"

echo "# terminal"
if [ ! -f "$DIR/bin/terminal" ];then
	install "$DIR/commandes/terminal.sh" "$DIR/bin/terminal"
fi

echo "# Usage : terminal\n"
find $DIR/commandes/* | while read c
do
	f=$(realpath $c)
	commande=${c##*/}
	commande=${commande/.sh/}	

	[[ $commande == "terminal" ]] && continue

	echo "# $commande"
	# La commande est-elle installée ?
	# install
	install "$DIR/commandes/$commande.sh" "$DIR/bin/$commande"
	echo "# Usage : $commande help\n"

done

echo "Relancer le terminal"
echo ". $HOME/.bash_profile\n"
echo "\n\n"
