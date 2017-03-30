#!/bin/sh

# Convertir le fichier excel en csv pour excel FR.

source="$1"
dest="${1/xlsx/csv}"
in2csv "$source" > "$dest.tmp"
csvformat -D \; "$dest.tmp" | iconv -f UTF-8 -t macintosh > "$dest"
rm "$dest.tmp"

echo "OK"
