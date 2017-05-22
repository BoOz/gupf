#!/bin/sh

# Convertir le fichier excel en csv pour excel FR.

command -v csvformat >/dev/null 2>&1 || { echo >&2 "\nErreur. Installer csvkit pour faire fonctionner la commande. pip install csvkit\n"; exit 1; }

source="$1"
dest="${1/xlsx/csv}"
in2csv "$source" > "$dest.tmp"
csvformat -D \; "$dest.tmp" | iconv -f UTF-8 -t macintosh > "$dest"
rm "$dest.tmp"

echo "OK"
