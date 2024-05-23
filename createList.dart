import 'dart:math';
import './cell.dart';
import 'randomNumber.dart';
import 'setSimulation.dart';

 /*
List<Cell> cellsList( int length, Terrain terrain ){
    return List.generate(length, (_) => Cell('inflammable')); 
}
*/

// créer une liste de cellules inflammables ou inertes en fonction du terrain
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
      // return List.generate(length, (_) => random.nextDouble() < 0.95 ? Cell('inflammable') : Cell('inert'));
    case Terrain.spaced:
    int numberOfInertCells = (length * 0.20).round();
      Set<int> inertIndices = {};
      while (inertIndices.length < numberOfInertCells) {
        inertIndices.add(random.nextInt(length));
      }
      return List.generate(length, (index) => inertIndices.contains(index) ? Cell('inert') : Cell('inflammable'));
      // return List.generate(length, (_) => random.nextDouble() < 0.80 ? Cell('inflammable') : Cell('inert'));
    case Terrain.sparse:
    int numberOfInertCells = (length * 0.5).round();
      Set<int> inertIndices = {};
      while (inertIndices.length < numberOfInertCells) {
        inertIndices.add(random.nextInt(length));
      }
      return List.generate(length, (index) => inertIndices.contains(index) ? Cell('inert') : Cell('inflammable'));
      // return List.generate(length, (_) => random.nextDouble() < 0.50 ? Cell('inflammable') : Cell('inert'));
    default:
      return [];
  }
}
