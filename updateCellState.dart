import './cell.dart';

// Fonction pour mettre à jour l'état d'une cellule spécifique
void updateCellState(Cell cell, int round) {
  if (round >= 3 && cell.state == 'enflammée') {
    cell.state = 'brûlé et chaud';  // Change l'état à 'brûlé et chaud'
  }
}
