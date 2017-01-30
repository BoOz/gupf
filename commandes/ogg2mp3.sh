#!/bin/sh

# Convertir les ogg en mp3 avec ffmpeg

## Glisser le script dans le terminal, taper [espace], glisser le repertoire ogg à convertir puis entrée.

# A t'on un recu un repertoire source en argument ?
(( ${#1} > 0)) && source="$1"

# Sinon on se met là ou est appelé le script.
if [[ "$source" == "" ]] ; then
	source="$PWD"
fi


echo "\n* Conversion mp3 des Ogg situés dans $source\n"

rep=${source##*/}

[[ "$rep" == "ogg" ]] && dest="${source/ogg/mp3}"
[[ "$rep" == "ogg" ]] || dest="${source}"

[ ! -d "$dest" ] && mkdir "$dest"

find "$source" -name "*.wav" | while read f; do

	file=$(basename "$f")
	file="${file// /_}"
	
	fdest="$dest/${file/ogg/mp3}"
	
	#echo "$f > ${fdest}"
	#exit
	ffmpeg -i "$f" -acodec libmp3lame "${fdest}" < /dev/null


done