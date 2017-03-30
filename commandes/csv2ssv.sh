#!/bin/sh
# Convertir le fichier csv en "csv" d'après excel. Si on est en France Excel suppose que le séparateur est  ;...

source="$1"

echo "\nConversion de $source en $dest, mais avec le séparateur ';' (qui s'ouvre dans excel FR du coup).\n"

csvformat -D \; "$source" > "$source.tmp"
mv "$source.tmp" "$source"

echo "OK"
