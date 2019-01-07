# Tuto Git
https://git-scm.com/book/fr/v1/D%C3%A9marrage-rapide

## Mettre à jour un projet
`git pull`

Note : git pull = git fetch suivi de git merge

## Ajouter une modif
`git add <fichier>`

## Enregistrer la modif
`git commit -m"message de log"`



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

- Envoyer une branche sur le serveur
`git push origin <nom_de_la_branche>`

- Récuperer une branche distante
```
git fetch
git checkout -b <nom_de_la_branche> origin/<nom_de_la_branche>
```

- Effacer une branche distante
`git push origin :<nom_de_la_branche>`

- Cloner une branche
`git clone -b <nom_de_la_branche> --single-branch git@github.com:<depot>.git`

