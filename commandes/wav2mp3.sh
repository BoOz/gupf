#!/bin/sh

# Convertir les wav 48000 Hz 192k en mp3 avec ffmpeg

## Glisser le script wav2mp3 dans le terminal, taper [espace], glisser le repertoire wav à convertir puis entrée.

# A t'on un recu un repertoire source en argument ?
(( ${#1} > 0)) && source="$1"

# Sinon on se met là ou est appelé le script.
if [[ "$source" == "" ]] ; then
	source="$PWD"
fi

echo "\n* Conversion mp3 48 000 Hz des wav : $source\n"

find "$source" -name "*.wav" | while read f; do

	# Si on a affaire à un fichier wav, on le converti à coté de la ou il est.
	if [ -f "$source" ] ; then
		ffmpeg -i "$f" -codec:a libmp3lame -qscale:a 2 -ar 48000 -ab 192k "${source/wav/mp3}" < /dev/null;
	else
	# si on a affaire à un répertoire wav dans le path, on crée un repertoire mp3
		dest=${source/wav/mp3}
		[ ! -d "$dest" ] && mkdir -p "$dest"
	
		file=$(basename "$f")
		file="${file// /_}"
		fdest="$dest/${file/.wav/.mp3}"

		ffmpeg -i "$f" -codec:a libmp3lame -qscale:a 2 -ar 48000 -ab 192k "${fdest}" < /dev/null;
	fi
	
done
