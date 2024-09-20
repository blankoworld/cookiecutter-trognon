# {{ cookiecutter.project_name }}

Un lanceur de commandes personnalisées pour votre projet de développement.

Exemple : 

```bash
# Affiche l'aide
./{{ cookiecutter.__command_slug }} help

# Installe votre projet (vous devez définir ce que `install` fait)
./{{ cookiecutter.__command_slug }} install

# créé un dump de la base de données
./{{ cookiecutter.__command_slug }} dump
```

# Dépendances

Ce projet nécessite des bibliothèques supplémentaires pour fonctionner.
Avec la commande `git` procédez ainsi&nbsp;: 

```bash
git submodule update --quiet --init --recursive 
```

# Fonctionnalités

* possibilité d'ajouter ses propres commandes
* système de configuration pour le chargement des variables, ainsi que leur sauvegarde

# Comment ajouter une commande ?

Exemple avec une sous-commande "install".

1. Utilisez comme template le fichier command.example
1. crééez un fichier, par exemple install.sh avec
1. complétez le fichier install.sh avec les commandes à lancer pour l'installation de votre projet
1. ajoutez "install" à la liste des commandes autorisées dans la variable ALLOWED\_COMMANDS du fichier **{{ cookiecutter.__command_slug }}**

Vous pouvez désormais lancer votre commande de cette façon : `./{{ cookiecutter.__command_slug }} install`

# Rendre la commande disponible dans tout le système

1. vérifiez d'avoir complété le programme avec la commande `git submodule update --quiet --init --recursive `
1. placez ce dépôt à un endroit phare de votre système, par exemple dans **${HOME}/{{ cookiecutter.__project_slug }}**
1. ajoutez la ligne suivante dans ~/.bashrc ou bien ~/.zshrc : 

```
alias {{ cookiecutter.__command_slug }}="${HOME}/{{ cookiecutter.__project_slug }}/{{ cookiecutter.__command_slug }}"
```

Désormais la commande se lance **depuis n'importe où dans le système** avec l'alias `{{ cookiecutter.__command_slug }}`. Et les commandes d'aide en conséquence.

# Licence

Ce logiciel est sous licence EUPL v1.2 (Cf. le fichier LICENSE).

This software is available under the terms of EUPL licence (Cf. LICENCE file).

# Github project

This project uses Trognon on Github: https://github.com/blankoworld/trognon
