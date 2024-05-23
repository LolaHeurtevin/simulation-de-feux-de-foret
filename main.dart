import 'dart:io';

import './cell.dart';
import './createList.dart';
import './FindCellState.dart';
import './round.dart';
import './neighbors.dart';
import './setSimulation.dart';
import './round.dart';
import './updateCellState.dart';

// Variables gloables
int numberOfCells = 24;
List<Cell> list = [];

void main() { 

  // Définir l'indice de la cellule que nous voulons examiner
  //int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  // print('État de la cellule $index : ${find(list, index).state}');

  // print( 'Indices des voisines de la cellule ${neighbors(index, 24)} : ${result}');

  //Initialistaion 
  List<int> startingCells = chooseBurningCells(2);
  InitialisationSimulation initialisation = initialiserSimulation();

  list = cellsList(numberOfCells, initialisation.terrain);

  List<Cell> updatedCells = setBurningCell(list, startingCells);

  // Afficher l'état mis à jour des cellules
  for (int i = 0; i < updatedCells.length; i++) {
    print('Cellule $i : ${updatedCells[i].state}');
  }

  // Choisir le nombre de rounds
  int rounds = promptForRounds(); 
  print("Vous avez choisi $rounds rounds.");

  // Lancer la simulation des rounds avec mise à jour des états
  simulateRounds(updatedCells, rounds, initialisation.wind, initialisation.climat);
}
