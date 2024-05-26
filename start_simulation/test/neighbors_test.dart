import 'package:flutter_test/flutter_test.dart';

void main() {
  // la fonction qui prend une cellulle et recupere ses voisins
  List<int> getNeighbors(int index, int length) {
    List<int> neighbors = [];  // Liste pour stocker les indices des voisins

    // Ajouter le voisin de gauche si ce n'est pas la première colonne
    if (index % 6 != 0) {
      neighbors.add(index - 1);
    }

    // Ajouter le voisin de droite si ce n'est pas la dernière colonne
    if (index % 6 != 5) {
      neighbors.add(index + 1);
    }

    // Ajouter le voisin du haut si ce n'est pas la première rangée
    if (index >= 6) {
      neighbors.add(index - 6);
    }

    // Ajouter le voisin du bas si ce n'est pas la dernière rangée
    if (index < length - 6) {
      neighbors.add(index + 6);
    }

    return neighbors;  // Retourne la liste des voisins
  }

  // Test unitaire pour vérifier les voisins de la cellule avec l'index 7
  test('test de la cellule index=7', () {
    int index = 7;  // L'index de la cellule dont on veut vérifier les voisins
    int length = 24;  // La longueur totale de la grille (24 cellules)
    List<int> neighbors = getNeighbors(index, length);  // Appel de la fonction pour obtenir les voisins
    // Vérification que les voisins sont corrects
    expect(neighbors, [6, 8, 1, 13]);
  });
}
