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

## join

**Fusionner deux fichiers triés sur une colonne commune**

Sur la premiere colonne commune

```
join fichier1 fichier2
```

Sur la 3e du fichier1 et la deuxieme du fichier 2

```
join -13 -22 fichier1 fichier2
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

# Zip

zipper avec un mot de passe

``` 
zip -e fichier.zip fichier.txt
```

## csv kit
```
sudo pip3 install csvkit
```
http://csvkit.readthedocs.io

## extraire des n-grammes d'un texte
http://learntextvis.github.io/textkit/
https://github.com/learntextvis/textkit/issues/34

```
pip install -U textkit
```


## Extraire les infos ou le texte d'un PDF
```
brew install poppler
pdfinfo fichier.pdf
pdftotext fichier.pdf fichier.txt
```
https://doc.ubuntu-fr.org/poppler-utils


## Conversion HTML => Rtf
```
textutil -convert rtf -inputencoding utf-8 test.txt -output NewFileName.rtf
```
## table2csv : récuperer un tableau HTML en csv
pip install -U table2csv
table2csv http://en.wikipedia.org/wiki/List_of_Super_Bowl_champions > dump.txt

## Voir si on a déjà une clé `id_rsa.pub`
```
ls .ssh
```

## générer une cle ssh
```
ssh-keygen -b 4096
```
puis entrée à chaque prompt

## enregistrer un access ssh sur un serveur distant
```
brew install ssh-copy-id
ssh-copy-id user@server.net
```

## forcer un user pour une connexion ssh : `vim .ssh/config `
```
host server.net
     User annie
```

## barre de progression
```
brew install pv
```
## config mysql
`vim .my.cnf`

exemple
```
[client]
user=root
password=root
default-character-set=utf8mb4
```

## Droits sur les fichiers et répertoires

Sur Mac OSX

```
sudo chown -R $(whoami):admin /usr/local/*
&& sudo chmod -R g+rwx /usr/local/*
```


https://doc.ubuntu-fr.org/permissions
- Fichier : 664
- Dossier : 770

Pour ajouter les droits au groupe en tenant compte de la nature repertoire ou fichier des éléments inclus dans `monrep` :

```
chmod -R g+rwX monrep
```

**Copier un repertoire en conservant les droits**

```
cp -fra depart arrivée
```

Remplacer un repertoire par un autre

```
mv toto toto-old && mv toto-merge toto
```

**Évaluer la taille des dossiers et trier par poids décroissant**

```
du -mks * | sort -rn
```

**Synchroniser des volumes / dossiers**

```
rsync -azv $rep_source/ $rep_destination/
```

**Voir les enregistrement DNS d'un domaine**

```
dig wikipedia.fr ANY
dig ALL wikipedia.fr
host wikipedia.fr
```

**Chercher dans les logs**

`zgrep 154.59.124.74 access-2016*`


**copier a travers le réseau**

`scp source/locale/ server.net:`

**screen irssi**

```
/ screen irssi
```

puis quitter : ctrl a +d

revenir screen -rd
