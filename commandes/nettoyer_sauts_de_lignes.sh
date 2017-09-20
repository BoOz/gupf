#!/bin/sh
clear

# Doc
_DOC_NETTOYER="Préciser le fichier dont il faut nettoyer les sauts de lignes pour les mettre au format unix. \`nettoyer_sauts_de_lignes fichier.txt > fichier_propre.txt\`\n\n"
if [ -z "$1" ]; then
	echo "$_DOC_NETTOYER"	
	exit
fi
if [[ "$1" == "help" ]]; then
	echo "$_DOC_NETTOYER"	
	exit
fi

# Où sommes-nous ?
repertoire=${0%/*}
repertoire=${repertoire/\/commandes/}
repertoire=${repertoire/bin/}
#echo $repertoire
#exit

# init
source "$repertoire/inc/utils.sh"

nettoyer_sauts_de_lignes "$1"
