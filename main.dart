import './cell.dart';
import './CreateList.dart';
import './FindCellState.dart';
import './neighbors.dart';

// Point d'entrée principal du programme
void main() {
  int numberOfCells = 5; // Définir le nombre de cellules dans la liste
  List<Cell> list = cellsList(numberOfCells);  // Créer la liste

  // Définir l'indice de la cellule que nous voulons examiner
  int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  print('État de la cellule $index : ${find(list, index).state}');

  List<int> result = neighbors(index, 5);
  print( 'Indices des voisines de la cellule ${index} : ${result}');
}
