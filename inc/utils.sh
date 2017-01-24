#!/bin/sh

## Variables globales relatives au script appelant.

# Récuperer les options du script
# Parcourir les parametres envoyés
for f in "$@" ; do 
	# Chopper une éventuelle option d
	if [[ "$f" == "-d" ]] ; then
		_OPTION_D=true
		shift 1
	fi
done

# Path absolu du fichier à traiter
fichier_original=$(realpath "$1")
nom_fichier_original="${fichier_original%.*}"


## Fonctions utiles pour traiter des fichiers.

function nettoyer_sauts_de_lignes(){
# Les fichiers windows ont des saut de ligne CRLF
# Les vieux fichiers Mac ont des saut de lignes CR
# On veut des sauts de lignes Unix LF
# On veut aussi obligatoirementun saut de ligne en fin de fichier

# Usage : 
# cat fichier.txt | nettoyer_sauts_de_lignes
# nettoyer_sauts_de_lignes fichier.txt

	# cas d'usage en pipe
    if [ $# -eq 0 ]; then
        input=$(cat | tr '\r' '\n' | tr -s '\n')

	# cas d'usage en fonction
    else
        input=$(cat "$1" | tr '\r' '\n' | tr -s '\n')
    fi
    
    echo "$input"
    
}

