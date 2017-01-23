#!/bin/sh

# Fonctions utiles pour traiter des listes d'emails.

# compare deux fichiers et recrache le fichier A dédupliqué du fichier B.
# détecte au passage des doublons dans a ou b.
# si pas de second fichier on estime que c'est avec les desisnscrits qu'on dedup.

# il faut des fichiers avec une nouvelle ligne à chaque fin de ligne, meme la derniere
# essayer ca ?
# tail -c1 file | grep -qx $'\n' || echo >> file
# echo "$i-$base" >&2 #redirection standard output


function nettoyer_liste_emails(){

	# $repertoire_dedup est défini dans le script appelant dedup.sh
	nom_fichier_relatif="${1##*/}"
	nom_fichier_relatif="${nom_fichier_relatif%.*}"
	nom_fichier="$repertoire_dedup/${nom_fichier_relatif}"

	# Trouver des emails
	regex="[\(\(\[\[, <>|:;^]|\.\."
	non_regex="@"
	# tester si le domaine est valide   06lol@-ac-machin.fr
	invalide="@-"

	# le fichier est il une liste d'emails bien formatées ?
	touch "${nom_fichier}--KO.txt"
	cat "$1" | while read line 
		do
			#echo $line
			if [[  "$line" =~ $regex || ! $line =~ $non_regex || $line =~ $invalide ]]
				then
					echo "$line " >> "${nom_fichier}--KO.txt"
				else
					# on ne veut pas deux @
					m="${line//@/}"
					n=$(( ${#line} - ${#m} )) # == 1 en principe
				
					# on ne veut pas un email ou un domaine trop court
					domaine="${line##*@}" #rezo.net
					tld="${domaine##*.}"  #.net
					if [[ "$domaine" == "$tld" || "${line%%@*}" == "" ]] # pas de .tld à la fin || pas de truc avant le @
						then
							echo "$line" >> "${nom_fichier}--KO.txt"
						else
							if (( ${#line} < 3 || ${#tld} < 2 || ${n} > 1))
								then
									echo "$line" >> "${nom_fichier}--KO.txt"
								else
									# email valide
									# echo "$baserep // $line"
									echo "$line" >> "${nom_fichier}--valides.txt"
							fi
					fi
			fi
	done
	
	# compter les lignes
	nb_lignes=$(cat "${nom_fichier}--KO.txt" | wc -l | tr -d ' ')
	nouveau_nom="${nom_fichier}-${nb_lignes}-KO.txt"
	mv "${nom_fichier}--KO.txt" "$nouveau_nom"

	nb_lignes=$(cat "${nom_fichier}--valides.txt" | wc -l | tr -d ' ')
	nouveau_nom="${nom_fichier}-${nb_lignes/\t/}-valides.txt"
	mv "${nom_fichier}--valides.txt" "$nouveau_nom"
	
	# renvoi au script appelant
	liste_propre="$nouveau_nom"
}

function dedoublonner_liste(){

	# $repertoire_details est définie dans le script dedup.sh
	nom_fichier_relatif="${1##*/}"
	nom_fichier_relatif="${nom_fichier_relatif%.*}"
	nom_fichier_relatif="${nom_fichier_relatif%.*}"
	# virer le compte d'adresses valides
	menage=$(echo "$nom_fichier_relatif" | grep -Eo "\d+-valides")
	nom_fichier_relatif=${nom_fichier_relatif/$menage/}

	nom_fichier="$repertoire_dedup/${nom_fichier_relatif}"
	
	export LC_ALL=C # trier correctement
	cat "$1" | tr '[A-Z]' '[a-z]' | sort | uniq > "$nom_fichier-dedoublonne.txt"
	cat "$1" | sort -f | uniq -i -d > "$nom_fichier-doublons.txt"

	# compter les lignes
	nb_lignes=$(cat "$nom_fichier-doublons.txt" | wc -l | tr -d ' ')
	nouveau_nom="${nom_fichier}-${nb_lignes}-doublons.txt"
	mv "$nom_fichier-doublons.txt" "$nouveau_nom"

	nb_lignes=$(cat "$nom_fichier-dedoublonne.txt" | wc -l | tr -d ' ')
	nouveau_nom="${nom_fichier}-${nb_lignes}-dedoublonne.txt"
	mv "$nom_fichier-dedoublonne.txt" "$nouveau_nom"

	# renvoi au script appelant
	liste_dedoublonnee="$nouveau_nom"
}

function dedupliquer(){
	# Prendre deux fichiers et renvoyer la liste des adresses qui sont dans le premier mais pas dans le second.
	# $repertoire_details est définie dans le script dedup.sh
	nom_fichier_relatif="${1##*/}"
	nom_fichier_relatif="${nom_fichier_relatif%.*}"
	
	# virer le compte d'adresses valides
	menage=$(echo "$nom_fichier_relatif" | grep -Eo "\d+-dedup")
	nom_fichier_relatif=${nom_fichier_relatif/$menage/}
	menage=$(echo "$nom_fichier_relatif" | grep -Eo "\d+-dedoublonne")
	nom_fichier_relatif=${nom_fichier_relatif/$menage/}
	nom_fichier="$repertoire_dedup/${nom_fichier_relatif}"
	
	# Ou sommes-nous ?
	nom_fichier2=${2##*/}
	nom_fichier2="${nom_fichier2%.*}"
	menage=$(echo "$nom_fichier2" | grep -Eo "\d+-dedup")
	nom_fichier2=${nom_fichier2/$menage/}
	menage=$(echo "$nom_fichier2" | grep -Eo "\d+-dedoublonne")
	nom_fichier2=${nom_fichier2/$menage/}
	
	fichier_communs="$nom_fichier-$nom_fichier2-communs.txt"
	[ -f "$fichier_communs" ] && rm "$fichier_communs"
	fichier_dedup="$nom_fichier-$nom_fichier2-dedup.txt"
	[ -f "$fichier_dedup" ] && rm "$fichier_dedup"

 if [ -f "$1" ] && [ -f "$2" ] ; then
	
	# Afficher les  lignes  se  trouvant à la fois dans  fichier1 et dans fichier2
	comm -1 -2 "$1" "$2"  > "${fichier_communs}"
			
	# Afficher les  lignes  se  trouvant  dans  fichier1  et  pas  dans fichier2	
	comm -2 -3 "$1" "$2"  > "${fichier_dedup}"

	# compter les lignes
	nb_lignes=$(cat "${fichier_communs}" | wc -l | tr -d ' ')
	nouveau_nom="$nom_fichier-$nom_fichier2-$nb_lignes-communs.txt"
	mv "${fichier_communs}" "$nouveau_nom"
	# renvoi au script appelant
	fichier_communs="$nouveau_nom"
	
	nb_lignes=$(cat "${fichier_dedup}" | wc -l | tr -d ' ')
	nouveau_nom="$nom_fichier-$nom_fichier2-$nb_lignes-dedup.txt"
	mv "${fichier_dedup}" "$nouveau_nom"
	# renvoi au script appelant
	fichier_dedup="$nouveau_nom"

	# globale définie dans le script sourcant
	taquet=$(($taquet + 1))

 fi

}

