import 'dart:io';
import './cell.dart';
import './updateCellState.dart';
import 'setSimulation.dart';

/**
 * function promptForRounds
 * demande à l'utilisateur de choisir le nombre de rounds
 * @return numberOfRounds le nombre de rounds
 */
int promptForRounds() {
  int numberOfRounds = 0; 

  while (numberOfRounds <= 0) { 
    print("Combien de rounds souhaitez-vous ? (doit être supérieur à 0) :");
    String? input = stdin.readLineSync(); // Lire l'entrée de l'utilisateur

    if (input != null && input.isNotEmpty) {
      int? enteredNumber = int.tryParse(input); // Essayer de convertir l'entrée en entier
      if (enteredNumber != null && enteredNumber > 0) {
        numberOfRounds = enteredNumber; 
      } else {
        print("Veuillez entrer un nombre valide supérieur à 0."); 
      }
    }
  }

  return numberOfRounds;
}

/**
 * function simulateRounds
 * enclenche la simulation et affiche l'état des cellules à chaque round
 * @param cells la liste des cellules
 * @param rounds le nombre de rounds
 * @param wind le vent choisi pour la simulation
 * @param climat le climat choisi pour la simulation
 */
void simulateRounds(List<Cell> cells, int rounds, Wind wind, Climat climat) {
  for (int round = 1; round <= rounds; round++) {
    if (round == 1 ) {
      for (int i = 0; i < cells.length; i++) {
        cells[i].index = i;
      }
    }
    for (int i = 0; i < cells.length; i++) {
      updateCellState(cells[i], wind, climat);
    }
    
    print("État des cellules au Round $round:");
    for (int i = 0; i < cells.length; i++) {
      print('Cellule $i : ${cells[i].state}');
    }
  }
}


