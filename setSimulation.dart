// fonction qui détermine quelles cases sont enflammées au début de la simulation
import 'dart:io';

List<int> setSimulation(int total) {
  List<int> results = [];  // Liste pour stocker les indices des cellules
  stdout.write('Veuillez saisir l\'index de la première cellule enflammée : ');

  String? userInput = stdin.readLineSync();

  if (userInput != null) {
    int? cellIndex = int.tryParse(userInput); 
    
    if (cellIndex != null) {
      print('Vous avez saisi l\'index de la cellule : $cellIndex');
    } else {
      print('Veuillez saisir un index de cellule valide (un entier).');
    }
  } else {
    print('Aucune entrée fournie.');
  }

  return results; 
}