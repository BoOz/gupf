#!/bin/sh

# Convertir les mkv en mp4 avec ffmpeg

## Glisser le script dans le terminal, taper [espace], glisser le repertoire à convertir puis entrée.

# A t'on un recu un repertoire source en argument ?
(( ${#1} > 0)) && source="$1"

# Sinon on se met là ou est le script.
if [[ "$source" == "" ]] ; then
	source="$PWD"
fi


echo "\n* Conversion mp4 des mkv situés dans $source\n"

rep=${source##*/}

[[ "$rep" == "mkv" ]] && dest="${source/mkv/mp4}"
[[ "$rep" == "mkv" ]] || dest="${source}"

[ ! -d "$dest" ] && mkdir "$dest"

find "$source" -name "*.mkv" | while read f; do

	file=$(basename "$f")
	file="${file// /_}"
	
	fdest="$dest/${file/mkv/mp4}"
	
	#echo "$f > ${fdest}"
	#exit
	ffmpeg -i "$f" "$fdest" < /dev/null;

done