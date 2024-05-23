// Fonction pour obtenir les indices des cellules voisines d'une cellule donnée
import 'cell.dart';

List<Cell> neighbors(int index, List<Cell> cells) {
  List<Cell> results = [];
  int total = cells.length;

  if (index > 0) results.add(cells[index - 1]);
  if (index < total - 1) results.add(cells[index + 1]);

  return results;
}