import './cell.dart';
import './CreateList.dart';
import './FindCellState.dart';
import './round.dart';
import './neighbors.dart';
import './setSimulation.dart';
import './round.dart';
import './updateCellState.dart';

void main() {
  int numberOfCells = 6; // Définir le nombre de cellules dans la liste
  List<Cell> list = cellsList(numberOfCells); 

  // Définir l'indice de la cellule que nous voulons examiner
  //int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  // print('État de la cellule $index : ${find(list, index).state}');

  // print( 'Indices des voisines de la cellule ${neighbors(index, 5)} : ${result}');

  List<int> startingCells = chooseBurningCells(1);
  List<Cell> updatedCells = setBurningCell(list, startingCells);

  // Afficher l'état mis à jour des cellules
  for (int i = 0; i < updatedCells.length; i++) {
    print('Cellule $i : ${updatedCells[i].state}');
  }
  
  //Initialistaion 
  InitialisationSimulation initialisation = initialiserSimulation();
  print('Climat choisi : ${initialisation.climat}');
  print('Terrain choisi : ${initialisation.terrain}');

  // Choisir le nombre de rounds
  int rounds = promptForRounds(); 
  print("Vous avez choisi $rounds rounds.");

  // Lancer la simulation des rounds avec mise à jour des états
  simulateRounds(updatedCells, rounds);
}
