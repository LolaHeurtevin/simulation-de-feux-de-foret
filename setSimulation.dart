import 'dart:io';
import './cell.dart';
import 'main.dart';

/**
 * fonction chooseBurningCells
 * permet à l'utilisateur de choisir les cellules enflamées au début de la simualtion
 * @param total le nombre total de cellules qui seront enflammées
 * @return results la liste des indices des cellules à enflammer
 */
List<int> chooseBurningCells(int total) {
  List<int> results = [];

  for (int i=1; i<=total; i++) {
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


/**
 * fonction setBurningCell
 * change l'état des cellules à enflammer avant le début de la simulation de inflammable à enflammées
 * @param cellList la liste des cellules
 * @param startingCells la liste des indices des cellules enflammées au début de la simulation
 * @return cellList la liste des cellules
 */
List<Cell> setBurningCell(List<Cell> cellList, List<int> startingCells) {
  if (startingCells.length == initialNumberOfBurningCells &&
      startingCells.every((index) => index >= 0 && index < cellList.length)) {
    for (int index in startingCells) {
      cellList[index].state = 'enflammée';
    }
  } else {
    print('Les indices donnés ne sont pas valides.');
  }

  return cellList;
}

//// Initialisation du terrain et climat /////

enum Climat { humid, normal, dry, veryDry }

enum Terrain { continu, close, spaced, sparse }

enum Wind { none, moderate, strong, violent }

class InitialisationSimulation {
  Climat climat;
  Terrain terrain;
  Wind wind;

  InitialisationSimulation(this.climat, this.terrain, this.wind);
}

Climat chooseClimat() {
  print('Choisissez le type de climat :');
  print('1. Humide');
  print('2. Normal');
  print('3. Sec');
  print('4. Très sec');
  
  stdout.write('Entrez le numéro correspondant au type de climat : ');
  int choix = int.parse(stdin.readLineSync()!);

  switch (choix) {
    case 1:
      return Climat.humid;
    case 2:
      return Climat.normal;
    case 3:
      return Climat.dry;
    case 4:
      return Climat.veryDry;
    default:
      print('Choix invalide, sélection par défaut : Normal');
      return Climat.normal;
  }
}

Terrain chooseTerrain() {
  print('Choisissez le type de terrain :');
  print('1. Continue');
  print('2. Peu espacée');
  print('3. Espacée');
  print('4. Clairsemé');
  
  stdout.write('Entrez le numéro correspondant au type de terrain : ');
  int choix = int.parse(stdin.readLineSync()!);

  switch (choix) {
    case 1:
      return Terrain.continu;
    case 2:
      return Terrain.close;
    case 3:
      return Terrain.spaced;
    case 4:
      return Terrain.sparse;
    default:
      print('Choix invalide, sélection par défaut : Continue');
      return Terrain.continu;
  }
}

Wind chooseWind() {
  print('Choisissez le type de vent :');
  print('1. Null');
  print('2. Modéré');
  print('3. Fort');
  print('4. Violent');
  
  stdout.write('Entrez le numéro correspondant au type de vent : ');
  int choix = int.parse(stdin.readLineSync()!);

  switch (choix) {
    case 1:
      return Wind.none;
    case 2:
      return Wind.moderate;
    case 3:
      return Wind.strong;
    case 4:
      return Wind.violent;
    default:
      print('Choix invalide, sélection par défaut : modéré');
      return Wind.moderate;
  }
}

InitialisationSimulation initialiserSimulation() {
  Climat climatChoisi = chooseClimat();
  Terrain terrainChoisi = chooseTerrain();
  Wind ventChoisi = chooseWind();
  return InitialisationSimulation(climatChoisi, terrainChoisi, ventChoisi);
}
