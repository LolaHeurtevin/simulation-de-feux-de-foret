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


// fonction pour changer l'état des cellules à enflammer avant le début de la simulation de inflammable à enflammées
List<Cell> setBurningCell(List<Cell> cellList, List<int> startingCells) {
  if (startingCells.length == 2 &&
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

class InitialisationSimulation {
  Climat climat;
  Terrain terrain;

  InitialisationSimulation(this.climat, this.terrain);
}

Climat choisirClimat() {
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

Terrain choisirTerrain() {
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

InitialisationSimulation initialiserSimulation() {
  Climat climatChoisi = choisirClimat();
  Terrain terrainChoisi = choisirTerrain();
  return InitialisationSimulation(climatChoisi, terrainChoisi);
}
