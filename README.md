# Projet de simulation de feux de foret 
Ce projet a pour ambition de réaliser un simulateur de feux de forêt. Les utilisateurs peuvent sélectionner les cellules à enflammer au début de la simulation, configurer les paramètres de simulation (climat, terrain, vent), et définir le nombre de tours, puis exécuter la simulation.

# Attention

Le code Dart à la racine contient uniquement la logique en Dart et peut être exécuté directement en Dart que dans le terminal. Pour cela, allez à la racine du projet `simulation-de-feux-de-foret` et exécutez `main.dart`. 
Par contre, notre application Flutter finale se trouve dans ce dossier `simulation-de-feux-de-foret/start_simulation`.

## Table des matières
- [Installer le projet](##installer-le-projet)
- [Lancer le projet](##lancer-le-projet)
- [Compiler le projet vers une plateforme cible](##compiler-le-projet-vers-une-plateforme-cible)
- [Lancer les tests](##lancer-les-tests)
- [Cahier des charges](##cahier-des-charges)
- [Ressources](##ressources)
- [Difficultés et commentaires](##difficultes-et-commentaires)

## Installer le projet

Pour installer le projet, clonez le à l'aide de la commande 

~~~
git clone https://github.com/LolaHeurtevin/simulation-de-feux-de-foret.git
~~~

## Lancer le projet

Pour effectuer la simulation depuis un terminal (sans interface graphique), effectuer la commande suivante depuis le terminal à la racine du projet.
 
~~~
dart main.dart
~~~

## Compiler le projet vers une plateforme cible

Les instructions pour compiler le projet en Flutter avec une interface graphique se trouvent dans `./start_simulation/README.MD` dans la section "Configuration du projet" et "Exécution de l'application"
![image](https://github.com/LolaHeurtevin/simulation-de-feux-de-foret/assets/143880988/9a8c0e95-4b07-4018-a85a-1cbeb9bc4940)


## Lancer les test

On a effectué le test unitaire qui permet de tester la récuperation d'une cellule et de ces voisins. 
Le test se trouve dans `./start_simulation/test/neighbors_test.dart` et vérifie la fonctionnalité de la méthode getNeighbors qui récupère les voisins d'une cellule dans la grille de simulation. Cela garantit que les voisins sont correctement identifiés. 

Commande d'execution de test ( N'oubliez pas d'aller à la racine du dossier `./start_simulation` :

```bash
flutter test test/neighbors_test.dart
```
## Cahier des charges

Lien vers le cahier des charges : https://docs.google.com/document/d/1S-3BDyFjcKKO-Vv2XViiJzR556nLiNMrrN34vWx06OU/edit?usp=sharing

## Ressources

- Énoncé du projet
- Documentation de Dart : https://dart.dev/guides
- Stack Overflow (pour la fonction randomNumber)

## Difficultés et commentaires version Dart

La partie la plus compliqué du projet a été la gestion du vent. Dans l'énoncé, chaque force de vent entraîne un calcul différent des cellules voisines et des probabilités d'envoi des brandons pour chaque cellule. En raison des contraintes de temps que nous avons et des autres projets et dossiers sur lesquels nous devions travailler simulatnément, nous avons fait le choix d'adapter l'énoncé pour que la liste des cellules voisines soit toujours la même et que seule la probabilité d'envoi des brandons change avec la force du vent.
