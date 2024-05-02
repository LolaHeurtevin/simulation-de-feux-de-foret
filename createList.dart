import './cell.dart';
//créer une liste de cellules inflammable
List<Cell> cellsList( int length ){
    return List.generate(length, (_) => Cell('inflammable')); 
}
