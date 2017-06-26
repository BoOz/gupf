# Des commandes en plus dans le terminal

```
wav2mp3
ogg2mp3
mkv2mp4

csv2ssv
xls2ssv
ssv2tsv

dedup

terminal
```

# Installation avec Git

Dans le terminal taper la première fois :
```
git clone https://github.com/BoOz/terminal.git
cd terminal
chmod +x install.sh
./install.sh
```

Suivre les indications à l'écran pour ajouter `terminal` au PATH.

# Mise à jour 
```
terminal
```

# ajout au PATH
```
# ajouter des commandes au shell
export PATH=$PATH:la/ou/est/terminal/bin
```

## terminal

`terminal` : Met à jour `terminal`, affiche les informations d'installation et les commandes disponibles. 

## dedup

`dedup fichier1 [fichier2]` : créé un fichier avec les emails dans `fichier1` [mais pas dans `fichier2`]. 

Les doublons et les adresses invalides sont isolés dans un repertoire `fichier1_dedup` créé à coté de `fichier1`.

### Option `-d`
Dédupliquer en fin de processus avec les fichiers `$liste_rouge` définis dans `desinscrits.config`.

```
liste_rouge="chemin/vers/liste_rouge.csv"
liste_rouge2="chemin/vers/autre_liste_rouge.csv"
```

## ...



