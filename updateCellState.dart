import 'dart:math';
import './cell.dart';
import 'setSimulation.dart';

enum Climat { humid, normal, dry, veryDry }


// Fonction pour mettre à jour l'état d'une cellule spécifique
void updateCellState(Cell cell, int round) {
  if (round >= 3 && cell.state == 'enflammée') {
    cell.state = 'brûlé et chaud';  // Change l'état à 'brûlé et chaud'
  }
}

// fonction qui permet le changement ou non d'état d'une cellule après qu'elle ai reçu un brandon
// la cellule ayant reçu le brandon a différentes chances de s'enflammer en fonction du climat choisi
bool willInflammeAfterReceivingBrandon (Climat climat) {
  Random random = Random();
  double randomNumber = (random.nextDouble() * 10).toInt() / 10;

  switch (climat) {
    case Climat.humid:
      return randomNumber < 0.1;
    case Climat.normal:
      return randomNumber < 0.3;
    case Climat.dry:
      return randomNumber < 0.6;
    case Climat.veryDry:
      return randomNumber < 0.9;
    default:
      throw ArgumentError('Climat non valide');
  }
}
