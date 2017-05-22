#!/bin/sh
# Convertir le fichier csv en "csv" d'après excel. Si on est en France Excel suppose que le séparateur est  ;...

command -v csvformat >/dev/null 2>&1 || { echo >&2 "\nErreur. Installer csvkit pour faire fonctionner la commande. pip install csvkit\n"; exit 1; }

source="$1"

echo "\nConversion de $source en $dest, mais avec le séparateur ';' (qui s'ouvre dans excel FR du coup).\n"

csvformat -D \; "$source" > "$source.tmp"
mv "$source.tmp" "$source"

echo "OK"
