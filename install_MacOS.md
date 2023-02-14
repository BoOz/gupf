# Prérequis
A installer la première fois :

## Xcode pour avoir Git et SVN
(depuis l'appstore)
Puis
```
xcode-select --install
```
## Homebrew et cask
https://brew.sh/index_fr.html

## Node
pour installer des paquets avec `npm install xxx`.
```
brew install node
```


# Serveur web local avec Mac OS 

## Apache / PHP / Mysql
https://github.com/BoOz/terminal/blob/master/APACHE_MYSQL_PHP.md


# Commandes utiles

## wget
`brew install wget`

## autres commandes unix oubliées par MacOSX
`brew install coreutils`

## imagemagick, traitement images et PDF
```
brew install imagemagick
brew install ghostscript
```
## spip-cli, SPIP en lignes de commandes
https://contrib.spip.net/SPIP-Cli

## FTP
`brew install inetutils`


## Réinstaller python car l'install de Mac pose des soucis
```
brew reinstall python
```

## pip, pour installer des scripts python
```
pip devient pip3
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
