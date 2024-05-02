// la classe Cell représente une cellule
class Cell {
  String state; // stocker l'etat d'une cellule
  Cell(this.state); // constructeur d'initialisation
}

//créer une liste de cellules 
List<Cell> cellsList( int length ){
    return List.generate(length, (_) => Cell('inflammable')); 
}



