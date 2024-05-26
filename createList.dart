import 'dart:math';
import './cell.dart';
import 'setSimulation.dart';

 /**
  * fonction cellsList
  * créer une liste de cellules inflammables ou inertes en fonction du terrain choisi durant l'initialisation
  * @params lenght le nombre de cellules
  * @param terrain le type de terrain
  * @return la liste des cellules
*/
List<Cell> cellsList(int length, Terrain terrain) {
  Random random = Random();

  switch (terrain) {
    case Terrain.continu:
      return List.generate(length, (_) => Cell('inflammable'));
    case Terrain.close:
      int numberOfInertCells = (length * 0.05).round();
      Set<int> inertIndices = {};
      while (inertIndices.length < numberOfInertCells) {
        inertIndices.add(random.nextInt(length));
      }
      return List.generate(length, (index) => inertIndices.contains(index) ? Cell('inert') : Cell('inflammable'));
    case Terrain.spaced:
    int numberOfInertCells = (length * 0.20).round();
      Set<int> inertIndices = {};
      while (inertIndices.length < numberOfInertCells) {
        inertIndices.add(random.nextInt(length));
      }
      return List.generate(length, (index) => inertIndices.contains(index) ? Cell('inert') : Cell('inflammable'));
    case Terrain.sparse:
    int numberOfInertCells = (length * 0.5).round();
      Set<int> inertIndices = {};
      while (inertIndices.length < numberOfInertCells) {
        inertIndices.add(random.nextInt(length));
      }
      return List.generate(length, (index) => inertIndices.contains(index) ? Cell('inert') : Cell('inflammable'));
    default:
      return [];
  }
}
