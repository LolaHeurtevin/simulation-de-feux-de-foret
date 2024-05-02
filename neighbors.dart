// Fonction pour obtenir les indices des cellules voisines d'une cellule donnée
List<int> neighbors(int index, int total) {
  List<int> results = [];  // Liste pour stocker les indices des voisins
  if (index > 0) results.add(index - 1);  // Ajoute le voisin de gauche si ce n'est pas la première cellule
  if (index < total - 1) results.add(index + 1);  // Ajoute le voisin de droite si ce n'est pas la dernière cellule
  return results;  // Retourne la liste des voisins
}