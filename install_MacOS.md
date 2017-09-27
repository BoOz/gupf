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

## Réinstaller python car l'install de Mac pose des soucis
```
brew reinstall python
```

## pip, pour installer des scripts python
```
sudo easy_install pip
pip install --upgrade setuptools
```

## csv kit
```
sudo pip install csvkit
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

## generer une cle ssh
```
ssh-keygen -b 4096
```
puis entrée à chaque prompt

## enregistrer un access ssh sur un serveur distant
```
brew install ssh-copy-id
ssh-copy-id user@server.net
```

## barre de progression
```
brew install pv
```
## config mysql
`vim .my.cnf`

exemple
```
[mysqldump]
user=root
password=xxxx
```

## Droits sur les fichiers et répertoires
https://doc.ubuntu-fr.org/permissions
- Fichier : 664
- Dossier : 770

Pour ajouter les droits au groupe en tenant compte de la nature repertoire ou fichier des éléments inclus dans `monrep` :

```
chmod -R g+rwX monrep
```
