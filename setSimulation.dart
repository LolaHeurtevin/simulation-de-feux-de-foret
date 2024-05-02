import 'dart:io';
import './cell.dart';

// fonction qui détermine quelles cases sont enflammées au début de la simulation
List<int> chooseBurningCells(int total) {
  List<int> results = [];  // Liste pour stocker les indices des cellules enfalmmées

  for (int i=0; i<=1; i++) {
    stdout.write('Veuillez saisir l\'index de la cellule à enflammer : ');

    String? userInput = stdin.readLineSync();

    if (userInput != null) {
      int? cellIndex = int.tryParse(userInput); 

      if (cellIndex != null) {
        results.add(cellIndex);
      } else {
        print('Veuillez saisir un index de cellule valide (un entier).');
      }
    } else {
      print('Aucune entrée fournie.');
    }
  }

  return results; 
}

