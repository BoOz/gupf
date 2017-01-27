# Commandes en plus dans le terminal

**dedup**

`dedup fichier1 [fichier2]` : créé un fichier avec les emails dans `fichier1` [mais pas dans `fichier2`]. 

Les doublons et les adresses invalides sont isolés dans un repertoire `fichier1_dedup` créé à coté de `fichier1`.

Option `-d`
- Dédupliquer en fin de processus avec les fichiers `$liste_rouge` définis dans `desinscrits.config`.

```
liste_rouge="chemin/vers/liste_rouge.csv"
liste_rouge2="chemin/vers/autre_liste_rouge.csv"
```


**...**


**Installation avec Git**

Dans le terminal taper la première fois :
```
git clone https://github.com/BoOz/terminal.git
cd terminal
chmod +x install.sh
./install.sh
```

Si besoin relancer l'installation en glissant `install.sh` dans le terminal.

**Dépendances**

Sous MacOSX installer aussi
`brew install coreutils`

**Mise à jour :**
```
cd la/ou/est/terminal
git pull
./install.sh
```

**Autres commandes utiles**

Installer homebrew et cask
Press Command+Space and type Terminal and press enter/return key.
```
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null 2> /dev/null ; brew install caskroom/cask/brew-cask 2> /dev/null
```

Conversion HTML => Rtf
```
brew cask install openoffice
brew install unoconv
```
