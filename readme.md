# Runner de tâche

## Description

Ce module est un server Puma qui permet de lancer n'importe quelle tâche sur l'ordinateur à partir d'une adresse URL.

Il permet particulièrement de lancer des processus depuis l'application **`Rappel`**.

Par exemple, dans *Rappel*, on définit une tâche avec en URL : `http://:1111?script=dit&args=Bonjour`. On double-cliquant sur cette URL dans la tâche, cela fait dire « Bonjour » à l'ordinateur.

## Liste des scripts

Les scripts utilisables sont définis dans le dossier `scripts`.

## Annexe

### Prérequis

Pour pouvoir fonctionner de façon transparente, il faut lancer ce serveur au démarrage, simplement en appelant le binaire `bin/launch`.
