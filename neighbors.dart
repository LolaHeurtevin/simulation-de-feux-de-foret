// Fonction pour obtenir les indices des cellules voisines d'une cellule donnée
List<int> neighbors(int index, int total) {
  List<int> results = [];  
  if (index > 0) results.add(index - 1);  
  if (index < total - 1) results.add(index + 1); 
  return results; 
}