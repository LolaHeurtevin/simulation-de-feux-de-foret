import 'cell.dart';

/**
 * fonction neighbors
 * @param index l'indice de la cellule dont on veut trouver les voisins
 * @param cells la liste des cellules
 * @return results la liste des cellules voisines
 */
List<Cell> neighbors(int index, List<Cell> cells) {
  List<Cell> results = [];
  int total = cells.length;

  if (index > 0) results.add(cells[index - 1]);
  if (index < total - 1) results.add(cells[index + 1]);

  return results;
}