#!/bin/sh
clear

# Doc
_DOC_DEDUP="Préciser le fichier à dedupliquer.\ndedup fichier1 [fichier2] [...] # emails dans fichier1 [mais pas dans fichier2] [ni d'autres fichiers]. fichier1 est formaté, dédoublonné et trié.\n\nOptions:\n-d : ajoute à la queue de deduplication les fichiers définis dans le fichier \`desinscrits.config\`.\n\n"
if [ -z "$1" ]; then
	echo "$_DOC_DEDUP"	
	exit
fi
if [[ "$1" == "help" ]]; then
	echo "$_DOC_DEDUP"	
	exit
fi

# Où sommes-nous ?
repertoire=${0%/*}
repertoire=${repertoire/\/commandes/}
# init
source "$repertoire/inc/utils.sh"

# Si option -d, forcer la déduplication sur des listes rouges définies dans le fichier desinscrits.config.
if [ -f "$repertoire/desinscrits.config" ] && [ "$_OPTION_D" = true ] ; then
	source "$repertoire/desinscrits.config"
	set $* "$liste_rouge" "$liste_rouge2"
fi

# vérif
#for f in "$@" ; do 
#	echo ">>$f<<"
#done
#exit

# Doc
if [ ! -f "$1" ] ; then
 echo "$_DOC_DEDUP"	
 exit
fi

source "$repertoire/inc/emails.sh"

# Définir un repertoire à coté du fichier maitre pour mettre le détail des opérations. Il sera dispo dans les script inclus
repertoire_dedup="${nom_fichier_original}_dedup"
[ ! -d "$repertoire_dedup" ] && mkdir "$repertoire_dedup"
# vider le répertoire si besoin.
(( $(ls "$repertoire_dedup" | wc -l | tr -d ' ') > 0 )) && rm "${repertoire_dedup}"/*

# Dédupliquer les adresses emails d'un fichier `emails.txt`, une adresse email par ligne.

# Chercher des doublons
# array
declare -a fichiers_dedoublonnes
# index
index=0

for f in "$@" ; do 
		
		((${#f} == 0)) && continue
		[ ! -f "${f}" ] && continue

		# Nettoyer la liste (emails invalides)
		nbl=$(cat "$f" | nettoyer_sauts_de_lignes | wc -l | tr -d ' ')
		echo  "Evaluation des emails dans $f ($nbl lignes)"
		nettoyer_liste_emails "$f"	
		nb=$(wc -l < "${liste_propre}")

		echo "${liste_propre##*/} : $((nb)) emails valides, $((nbl - nb)) emails invalides"
		
		# Generer la liste des emails dédoublonnés, en uniformisant la casse
		dedoublonner_liste "${liste_propre}"
		echo "${liste_dedoublonnee##*/} : $((nb - $(wc -l < ${liste_dedoublonnee}))) doublon(s) enlevé(s)\n"

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
	echo  "${fichier_dedup##*/} : $((nb_dedup)) ligne(s) restantes, $((nb_paires)) enlevés\n"
done

nb_lignes=$(cat "${fichier_dedup}" | wc -l | tr -d ' ')
fichier_final="$nom_fichier_original-$nb_lignes-dedup.txt"

cp "${fichier_dedup}" "$fichier_final"

echo  "\nFichier final : ${fichier_final##*/} ($(($(wc -l < "$fichier_final"))) lignes), $(( $(($(wc -l < "$1"))) - $(($(wc -l < "$fichier_final"))) )) lignes enlevées."
		
echo  "\n\n"
