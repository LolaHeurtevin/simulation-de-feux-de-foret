import './cell.dart';
import './CreateList.dart';
import './FindCellState.dart';
import './neighbors.dart';
import './setSimulation.dart';

// Point d'entrée principal du programme
void main() {
  int numberOfCells = 5; // Définir le nombre de cellules dans la liste
  List<Cell> list = cellsList(numberOfCells);  // Créer la liste

  // Définir l'indice de la cellule que nous voulons examiner
  int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  // print('État de la cellule $index : ${find(list, index).state}');

  // print( 'Indices des voisines de la cellule ${neighbors(index, 5)} : ${result}');

  // print('la cellules enflammée est ${chooseBurningCells(5)}');
  List<int> startingCells = chooseBurningCells(5);
  List<Cell> updatedCells = setBurningCell(list, startingCells);

  // Afficher l'état mis à jour des cellules
  for (int i = 0; i < updatedCells.length; i++) {
    print('Cellule $i : ${updatedCells[i].state}');
  }
}
