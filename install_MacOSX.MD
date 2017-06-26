# Sous MacOSX installer la première fois :

## xcode (depuis l'appstore) pour avoir Git et SVN

## Apache / PHP / Mysql
https://github.com/BoOz/terminal/blob/master/APACHE_MYSQL_PHP.md

## Homebrew et cask
https://brew.sh/index_fr.html


# Commandes utiles

## wget

## autres commandes unix oubliées par MacOSX
`brew install coreutils`

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

## spip-cli, SPIP en lignes de commandes
https://contrib.spip.net/SPIP-Cli

## imagemagick, traitement images et PDF
```
brew install imagemagick
brew install ghostscript
```

## Extraire le texte d'un PDF
```
brew install poppler
```

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
