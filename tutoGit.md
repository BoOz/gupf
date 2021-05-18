# Tuto Git
https://git-scm.com/book/fr/v1/D%C3%A9marrage-rapide

## Récupérer un projet la première fois
`git clone git@github.com:<depot>.git`

## Vérifier sur quel dépot on est

`git remote -v`

## Mettre à jour un projet
`git pull`

Note : git pull = git fetch suivi de git merge

## Ajouter une modif
`git add <fichier>`

## Enregistrer la modif
`git commit -m"message de log"`

## Ajouter et enregistrer toutes les modifs d'un coup
`git commit -am "message de log"`

## Envoyer sur le dépot distant
`git push`

## Rectifier des erreurs

Si on a oublié un truc dans un commit (un git add par ex), on le fait puis on
`git commit --amend`

Si on a add un truc qu'on voulait pas add
`git reset HEAD <fichier>`

Si on veut effacer les modifs sur un fichier et revenir à l'état de départ

`git checkout -- <fichier>`

## Branches

- Lister les banches
```
git branch
git branch -v
git branch --merged (les effacer du coup)
git branch --no-merged (prévoir de les merger ou les effacer)
```

- Créer une branche
`git branch <nom_de_la_branche>`

exemple :

```
git branch dev/issue_6
git checkout dev/issue_6
git commit -am "message d'explication"
git push -u origin dev/issue_6
```

Puis aller faire une PR sur la forge.

- Effacer une branche
```
git branch -d <nom_de_la_branche>
git branch -D <nom_de_la_branche> (même si des trucs ne sont pas commités)
```

- Changer de branche
```
git checkout test (HEAD se déplace sur la branche test)
git checkout master (HEAD revient au master)
```

- Fusionner des branches (reporter test dans master)
```
git checkout master
git merge test
```

- Récupérer sur sa branche les commit intervenus sur le master ??

```
git pull origin/master 
```

- Envoyer une branche sur le serveur
`git push origin <nom_de_la_branche>`

- Récuperer une branche distante
```
git fetch
git checkout -b <nom_de_la_branche> origin/<nom_de_la_branche>
```


- voir la différence en le master et une branche
```
git diff master labranche
```

- Effacer une branche distante
`git push origin :<nom_de_la_branche>`

- Cloner une branche
`git clone -b <nom_de_la_branche> --single-branch git@github.com:<depot>.git`


Voir aussi : https://ohshitgit.com/fr




**Git-pull.sh**

Pull tous les repertoire d'un sous repertoire.

```
ls | xargs -I{} git -C {} pull
ls | xargs -P10 -I{} git -C {} pull
```
