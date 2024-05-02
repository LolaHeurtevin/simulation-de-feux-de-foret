// la classe Cell représente une cellule
class Cell {
  String state; // stocker l'etat d'une cellule
  Cell(this.state); // constructeur d'initialisation
}

//créer une liste de cellules inflammable
List<Cell> cellsList( int length ){
    return List.generate(length, (_) => Cell('inflammable')); 
}

// trouver la cellule à un indice spécifique
Cell find(List<Cell> cells, int index) {
  return cells[index];
}

// Point d'entrée principal du programme
void main() {
  int numberOfCells = 5; // Définir le nombre de cellules dans la liste
  List<Cell> list = cellsList(numberOfCells);  // Créer la liste

  // Définir l'indice de la cellule que nous voulons examiner
  int index = 2;
  
  // Affiche l'état de la cellule à l'indice spécifié
  print('État de la cellule $index : ${find(list, index).state}');
}







