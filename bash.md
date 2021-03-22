# Des commandes en bash

## comm

**Afficher les  lignes  se  trouvant à la fois dans  fichier1 et dans fichier2**
```
comm -1 -2 fichier1 fichier2
```

**Afficher les  lignes  se  trouvant  dans  fichier1  et  pas  dans fichier2**
```
comm -2 -3 fichier1 fichier2
```
 
# awk

**Afficher une alerte si le nombre de colonne ne vas pas et certains champs dans certains cas**

Pour taper le caractère "tab" avec un Mac dans le terminal :  Control + V + Tab 

```
cat "$file" | awk -F"	" '
	NF != 30 {print "Cette ligne a plus de 30 colonnes ("NF") : \n"$0"\n\n"}
	$4 == "MD" && $13 > 0 {
		# print $4 "\t" $13
		print $0 > "stats/md.txt"
	}
'
```

