import './cell.dart';
import './CreateList.dart';
import './FindCellState.dart';
import './round.dart';

// Point d'entrée principal du programme
void main() {
  int numberOfCells = 6; // Définir le nombre de cellules dans la liste
  List<Cell> list = cellsList(numberOfCells);  // Créer la liste

  // Définir l'indice de la cellule que nous voulons examiner
  int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  print('État de la cellule $index : ${find(list, index).state}');

  // Choisir le nombre de rounds
  int rounds = promptForRounds(); 
  print("Vous avez choisi $rounds rounds.");
}

