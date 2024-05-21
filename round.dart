import 'dart:io';
import './cell.dart';
import './updateCellState.dart';

// Fonction pour demander le nombre de rounds à l'utilisateur
int promptForRounds() {
  int numberOfRounds = 0; // Initialiser le nombre de rounds

  while (numberOfRounds <= 0) { // Assurer que le nombre de rounds est supérieur à 0
    print("Combien de rounds souhaitez-vous ? (doit être supérieur à 0) :");
    String? input = stdin.readLineSync(); // Lire l'entrée de l'utilisateur

    if (input != null && input.isNotEmpty) {
      int? enteredNumber = int.tryParse(input); // Essayer de convertir l'entrée en entier
      if (enteredNumber != null && enteredNumber > 0) {
        numberOfRounds = enteredNumber; // Assigner le nombre valide à numberOfRounds
      } else {
        print("Veuillez entrer un nombre valide supérieur à 0."); // Message pour une entrée non valide
      }
    }
  }

  return numberOfRounds; // Retourner le nombre de rounds validé
}

// Fonction pour simuler les rounds
void simulateRounds(List<Cell> cells, int rounds) {
  for (int round = 1; round <= rounds; round++) {
    // Mise à jour de l'état des cellules pour les rounds spécifiques
    for (int i = 0; i < cells.length; i++) {
      updateCellState(cells[i], round);  // Mettre à jour l'état de chaque cellule
    }
    // Affichage de l'état des cellules à chaque round
    print("État des cellules au Round $round:");
    for (int i = 0; i < cells.length; i++) {
      print('Cellule $i : ${cells[i].state}');
    }
  }
}


