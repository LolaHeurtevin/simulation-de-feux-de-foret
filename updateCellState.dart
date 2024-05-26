import './cell.dart';
import 'isBrandonSent.dart';
import 'main.dart';
import 'neighbors.dart';
import 'setSimulation.dart';
import './randomNumber.dart';

/** 
 * fonction updateCellState
 * met à jour l'état d'une cellule spécifique (à chaque round) en fonction de son état actuel et des conditions de la simulation
 * @param cell la cellule
 * @param wind le vent
 * @param climat le climat
 */
void updateCellState(Cell cell, Wind wind, Climat climat) {
  if (cell.state == 'enflammée' && cell.lastUpdated >= 2) {
    cell.state = 'brûlé et chaud'; 
    cell.lastUpdated = 0;
  }

  if (cell.state == 'brûlé et chaud') {
    if (cell.lastUpdated >=1 && cellTurnsCold() == true) {
      cell.state = 'brûlé et froid';
      cell.lastUpdated = 0;
    } else {
      if (isBrandonSent(cell, wind)) {
      
        var cellNeighbors = neighbors(cell.index, list);
        for (int i=0; i<cellNeighbors.length; i++) {
          if (willInflammeAfterReceivingBrandon(climat)) {
            cellNeighbors[i].state = 'enflammée';
            cellNeighbors[i].lastUpdated = 0;
          }
        }
      }
    }
  }

  cell.lastUpdated += 1;
}


/**
 * fonction willInflammeAfterReceivingBrandon
 * permet le changement ou non d'état d'une cellule après qu'elle ai reçu un brandon
 * la cellule ayant reçu le brandon a différentes chances de s'enflammer en fonction du climat choisi
 * @param climat le climat choisi
 * @return un booléen
 */
bool willInflammeAfterReceivingBrandon (Climat climat) {

  switch (climat) {
    case Climat.humid:
      return randomNumber(0, 100) <= 10;
    case Climat.normal:
      return randomNumber(0, 100) <= 30;
    case Climat.dry:
      return randomNumber(0, 100) <= 60;
    case Climat.veryDry:
      return randomNumber(0, 100) <= 90;
    default:
      throw ArgumentError('Climat non valide');
  }
}

/**
 * fonction cellTurnsCold
 * détermine si une cellule passe dans l'état brulé et froid
 * @return un booléen
 */
bool cellTurnsCold() {
  return randomNumber(0, 100) <= 40;
}
