
# Documentation pour la Simulation de Feu de Forêt en Flutter

## Aperçu

Cette application Flutter simule un feu de forêt. Les utilisateurs peuvent sélectionner les cellules à enflammer, configurer les paramètres de simulation (climat, terrain, vent), et définir le nombre de tours, puis exécuter la simulation. L'état de la grille peut être enregistré dans un fichier.

![image](https://github.com/LolaHeurtevin/simulation-de-feux-de-foret/assets/143880988/cec41da9-61b6-4dfb-89c9-da484c4b16af)

## Prérequis

Assurez-vous d'avoir les éléments suivants installés sur votre système :

- [Flutter](https://flutter.dev/docs/get-started/install)
- [Dart](https://dart.dev/get-dart)
- Un IDE comme [VS Code](https://code.visualstudio.com/) ou [Android Studio](https://developer.android.com/studio)

### Attention

Le code Dart à la racine contient uniquement la logique en Dart et peut être exécuté directement en Dart que dans le terminal. Pour cela, allez à la racine du projet `simulation-de-feux-de-foret` et exécutez `main.dart`. 
Par contre, notre application Flutter finale se trouve dans ce dossier `simulation-de-feux-de-foret/start_simulation`.

### Configuration du Projet

1. **Cloner le dépôt** en utilisant le lien suivant :
   ```bash
   git clone https://github.com/LolaHeurtevin/simulation-de-feux-de-foret.git
   cd simulation-de-feux-de-foret/start_simulation
   ```

2. **Ouvrir le projet** dans votre IDE préféré.

3. **Installer les dépendances** en exécutant la commande suivante dans le terminal :
   ```bash
   flutter pub get
   ```

4. **Activer le mode développeur** sur votre appareil ou émulateur Android. Cela est nécessaire car l'application contient une fonctionnalité de sauvegarde de fichier texte sur l'ordinateur. Pour activer le mode développeur, suivez les instructions appropriées pour votre appareil/emulateur.

### Exécution de l'Application

1. **Connecter un appareil** (un appareil Android/iOS ou un émulateur).

2. **Exécuter l'application** en utilisant la commande suivante dans le terminal :
   ```bash
   flutter run
   ```

   Alternativement, vous pouvez utiliser le bouton "Run" dans votre IDE.

## Structure de l'Application

### `main.dart`

Le point d'entrée principal de l'application où l'application commence à s'exécuter.

### Classe `MyApp`

Le widget racine de l'application, configurant le thème et la page d'accueil.

### Classe `MyHomePage`

L'interface utilisateur principale de l'application. Elle contient :

- Une grille pour sélectionner et afficher l'état des cellules.
- Des menus déroulants pour sélectionner le climat, le terrain et le vent.
- Un champ de texte pour entrer le nombre de tours de simulation.
- Des boutons pour confirmer la configuration, réinitialiser la simulation et enregistrer l'état de la grille.

### Classe `Cell`

Représente chaque cellule dans la grille avec des propriétés telles que l'état, l'index, lastUpdatedRound, et fireDuration.

### Enums

- `Climat` - Représente les conditions climatiques (`humid`, `normal`, `dry`, `veryDry`).
- `Terrain` - Représente la densité du terrain (`continu`, `close`, `spaced`, `sparse`).
- `Wind` - Représente l'intensité du vent (`none`, `moderate`, `strong`, `violent`).

### Fonctions

- `cellsList` - Génère une liste de cellules en fonction du terrain sélectionné.
- `setBurningCell` - Définit l'état initial enflammé des cellules sélectionnées.
- `initialiserSimulation` - Initialise la simulation avec les paramètres sélectionnés.
- `simulateRounds` - Exécute la simulation pour le nombre spécifié de tours.
- `getNeighbors` - Obtient les cellules voisines pour un index donné.
- `updateCellState` - Met à jour l'état d'une cellule en fonction de la logique de simulation.
- `getFireProbability` - Renvoie la probabilité d'incendie en fonction du climat sélectionné.
- `windForce` - Renvoie la force du vent en fonction du vent sélectionné.
- `igniteNeighbors` - Enflamme les cellules voisines en fonction de la probabilité.

### Helpers UI

- `getColorForState` - Renvoie la couleur représentant l'état d'une cellule.
- `getTextColorForState` - Renvoie la couleur du texte pour une cellule en fonction de son état.
- `_buildColorLegend` - Construit le widget de légende des couleurs.

## Sauvegarde de l'État de la Grille

L'application permet de sauvegarder l'état final de la grille dans un fichier texte :

- Le fichier est sauvegardé dans le répertoire des documents de l'application.
- L'état de chaque cellule est écrit dans le format "Cell <index>: <state>".

Pour sauvegarder l'état de la grille :
1. Cliquez sur le bouton "Sauvegarder".
2. Un message de confirmation avec le chemin du fichier sera affiché.

## Utilisation

1. **Choisir les Paramètres** :
   - Climat : Sélectionnez la condition climatique dans le menu déroulant.
   - Terrain : Sélectionnez la densité du terrain dans le menu déroulant.
   - Vent : Sélectionnez l'intensité du vent dans le menu déroulant.

2. **Entrer les Tours** : Entrez le nombre de tours pour la simulation dans le champ de texte.

3. **Sélectionner les Cellules à Enflammer** : Choisissez deux cellules à enflammer en cliquant sur les indices correspondants dans la grille, par exemple les cellules 6 et 11.

4. **Confirmer la Configuration** : Cliquez sur le bouton "Confirmer" pour démarrer la simulation.

5. **Observer les Changements** : Observez les changements d'état dans la grille.

6. **Réinitialiser la Simulation** : Cliquez sur le bouton "Réinitialiser" pour réinitialiser la grille et les paramètres.

7. **Sauvegarder l'État de la Grille** : Cliquez sur le bouton "Sauvegarder" pour enregistrer l'état final de la grille dans un fichier.

## Exemple

Pour voir un exemple de simulation en action :

1. Exécutez l'application.
2. Choisissez les paramètres de climat, terrain et vent.
3. Entrez un nombre de tours, par exemple 2.
4. Sélectionnez deux cellules à enflammer, par exemple les cellules 6 et 11.
5. Cliquez sur "Confirmer" pour démarrer la simulation.
6. Observez les changements d'état dans la grille.
7. Cliquez sur "Sauvegarder" pour enregistrer l'état final de la grille.

## Dépannage

- Assurez-vous que tous les prérequis sont installés.
- Assurez-vous qu'un appareil ou émulateur est connecté avant d'exécuter l'application.
- Si l'application plante, vérifiez les messages d'erreur dans la console et assurez-vous que toutes les entrées sont valides.

## Conclusion

Cette application Flutter fournit une interface conviviale pour simuler et visualiser un feu de forêt en fonction de divers paramètres. Les utilisateurs peuvent configurer la simulation, observer la progression et enregistrer les résultats.

Assurez-vous d'avoir importé le package `path_provider` pour permettre la sauvegarde des fichiers :
```dart
import 'package:path_provider/path_provider.dart';
```
