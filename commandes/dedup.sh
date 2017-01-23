#!/bin/sh

clear
# Doc
if [ -z "$1" ] || [ ! -f "$1" ] ; then
 echo "\nPréciser le fichier à dedupliquer."	
 echo "dedup fichier1 [fichier2] [...] # emails dans fichier1 [mais pas dans fichier2] [ni d'autres fichiers]. \`fichier1\` est formaté, dédoublonné et trié.\n"
 exit
fi

# Ou sommes-nous ?
repertoire=${0%/*}
repertoire=${repertoire/\/commandes/}
source "$repertoire/inc/emails.sh"

# Quel fichier veut-on dédupliquer ?
fichier_original=$(realpath "$1")
nom_fichier_original="${fichier_original%.*}"
# sera dispo dans les script inclus
repertoire_dedup="${nom_fichier_original}_dedup"
[ ! -d "$repertoire_dedup" ] && mkdir "$repertoire_dedup"
(( $(ls "$repertoire_dedup" | wc -l | tr -d ' ') > 0 )) && rm "${repertoire_dedup}"/*

# Dédupliquer les adresses emails d'un fichier `emails.txt`, une adresse email par ligne.

# On enleve les desinscrits sur listes rouges
if [ -f "$repertoire/desinscrits.config" ] ; then
	source "$repertoire/desinscrits.config"
	# echo ">>> $liste_rouge"
	set "$*" "$liste_rouge" "$liste_rouge2"
fi

# vérif
#for f in "$@" ; do 
#	echo ">$f<"
#done



# Chercher des doublons
# array
declare -a fichiers_dedoublonnes
# index
index=0

for f in "$@" ; do 
		
		((${#f} == 0)) && continue
		[ ! -f "${f}" ] && continue

		# Nettoyer la liste (emails invalides)
		nbl=$(($(wc -l < "$f")))
		echo  "\nEvaluation des emails dans $f ($nbl lignes)"
		nettoyer_liste_emails "$f"	
		nb=$(wc -l < "${liste_propre}")

		echo "${liste_propre##*/} : $((nb)) emails valides, $((nbl - nb)) emails invalides"
		
		# Generer la liste des emails dédoublonnés, en uniformisant la casse
		dedoublonner_liste "${liste_propre}"
		echo "${liste_dedoublonnee##*/} : $((nb - $(wc -l < ${liste_dedoublonnee}))) doublon(s) enlevé(s)"

		# chopper la liste des arguments de dédup pour la suite.		
		fichiers_dedoublonnes[$index]="${liste_dedoublonnee}"
		index=$(($index + 1))

done 

echo "\n"

# si pas d'autre fichier
(( ${#fichiers_dedoublonnes[1]} ==0 )) && exit

echo  "* Déduplication"	
taquet=1 #le tableau commence a 0

# dédup
echo  "\nComparaison de ${fichiers_dedoublonnes[0]##*/} ($(($(wc -l < "${fichiers_dedoublonnes[0]}"))) lignes) et ${fichiers_dedoublonnes[1]##*/} ($(($(wc -l < "${fichiers_dedoublonnes[1]}"))) lignes)"


dedupliquer ${fichiers_dedoublonnes[0]} ${fichiers_dedoublonnes[1]}
# vars définies dans le script sourcé
nb_paires=`wc -l < "${fichier_communs}"`
nb_dedup=`wc -l < "${fichier_dedup}"`

echo  "${fichier_dedup##*/} : $((nb_dedup)) ligne(s) restantes, $((nb_paires)) enlevés"

while (( $taquet < ${#fichiers_dedoublonnes[@]} ))
do
	((${#f} == 0)) && continue
	echo  "\nComparaison de ${fichier_dedup} ($(($(wc -l < "${fichier_dedup}"))) lignes) et ${fichiers_dedoublonnes[$taquet]} ($(($(wc -l < "${fichiers_dedoublonnes[$taquet]}"))) lignes)"
	dedupliquer "${fichier_dedup}" "${fichiers_dedoublonnes[$taquet]}"
	# vars définies dans le script sourcé
	nb_paires=`wc -l < "${fichier_communs}"`
	nb_dedup=`wc -l < "${fichier_dedup}"`
	echo  "${fichier_dedup##*/} : $((nb_dedup)) ligne(s) restantes, $((nb_paires)) enlevés"
done



fichier_final="$nom_fichier_original-dedup.txt"
cp "${fichier_dedup}" "$fichier_final"

echo  "\nFichier final : ${fichier_final##*/} ($(($(wc -l < "$fichier_final"))) lignes), $(( $(($(wc -l < "$1"))) - $(($(wc -l < "$fichier_final"))) )) lignes enlevées."
		
echo  "\n\n"
