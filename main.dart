import './cell.dart';
import './createList.dart';
import './round.dart';
import './setSimulation.dart';

// Variables gloables
int numberOfCells = 24;
int initialNumberOfBurningCells = 2;
List<Cell> list = [];

void main() { 

  // Initialistaion 
  // L'utilisateur choisi les cellules qu'il veut enflammer au début de la simulation
  List<int> startingCells = chooseBurningCells(initialNumberOfBurningCells);
  // L'utilisateur choisi les conditions de la simulation (terrain, vent, climat)
  InitialisationSimulation initialisation = initialiserSimulation();

  // Création de la liste des cellules en fonction des paramètres
  list = cellsList(numberOfCells, initialisation.terrain);
  List<Cell> updatedCells = setBurningCell(list, startingCells);

  // L'utilisateur choisi le nombre de rounds
  int rounds = promptForRounds(); 
  print("Vous avez choisi $rounds rounds.");

  // Lancer la simulation des rounds avec mise à jour des états
  simulateRounds(updatedCells, rounds, initialisation.wind, initialisation.climat);
}
