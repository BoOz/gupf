#!/bin/sh

# Convertir le fichier ssv excel windows fr en tsv.

source="$1"
dest="$1.tsv"

cat "$source" | iconv -f "windows-1252" -t "UTF-8" | sed -e "s/;/	/g" > "$dest"

echo "Conversion de $1 vers $dest OK"
