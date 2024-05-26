import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

// Classe représentant une cellule dans la simulation de feu de forêt
class Cell {
  String state;
  int index;
  int lastUpdatedRound;
  int fireDuration;

  Cell(this.state, this.index)
      : lastUpdatedRound = 0,
        fireDuration = 0;
}

// Fonction pour générer une liste de cellules selon le terrain choisi
List<Cell> cellsList(int numberOfCells, Terrain terrain, Random random) {
  List<Cell> cells = List<Cell>.generate(numberOfCells, (index) => Cell('inflammable', index));
  int inflammableCells;

  switch (terrain) {
    case Terrain.continu:
      inflammableCells = numberOfCells;
      break;
    case Terrain.close:
      inflammableCells = (numberOfCells * 0.95).round();
      break;
    case Terrain.spaced:
      inflammableCells = (numberOfCells * 0.8).round();
      break;
    case Terrain.sparse:
      inflammableCells = (numberOfCells * 0.5).round();
      break;
    default:
      inflammableCells = numberOfCells;
  }

  int inerteCells = numberOfCells - inflammableCells;
  for (int i = 0; i < inerteCells; i++) {
    int randomIndex;
    do {
      randomIndex = random.nextInt(numberOfCells);
    } while (cells[randomIndex].state == 'inerte');
    cells[randomIndex].state = 'inerte';
  }

  return cells;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simulation de Feu de Forêt',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Simulation de Feu de Forêt'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<bool> selectedIndices = List.generate(24, (_) => false);
  final TextEditingController _roundsController = TextEditingController();
  List<Cell> cells = [];
  Climat? selectedClimat;
  Terrain? selectedTerrain;
  Wind? selectedWind;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    resetSimulation();
  }

  // Fonction pour gérer la confirmation des paramètres et lancer la simulation
  void _handleConfirmation() {
    List<int> indices = [];
    for (int i = 0; i < selectedIndices.length; i++) {
      if (selectedIndices[i]) {
        indices.add(i);
      }
    }

    int? rounds = int.tryParse(_roundsController.text);

    if (indices.length == 2 && rounds != null && rounds > 0 && selectedClimat != null && selectedTerrain != null && selectedWind != null) {
      setState(() {
        cells = setBurningCell(cells, indices);
        InitialisationSimulation initialisation = initialiserSimulation(
          selectedClimat!,
          selectedTerrain!,
          selectedWind!,
        );
        simulateRounds(cells, rounds, initialisation.wind, initialisation.climat);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez sélectionner deux indices, choisir toutes les options et entrer un nombre de rounds valide.')),
      );
    }
  }

  // Fonction pour réinitialiser la simulation
  void resetSimulation() {
    setState(() {
      cells = cellsList(24, selectedTerrain ?? Terrain.continu, random);
      selectedIndices = List.generate(24, (_) => false);
      _roundsController.clear();
    });
  }

  // Fonction pour définir les cellules enflammées au début de la simulation
  List<Cell> setBurningCell(List<Cell> cellList, List<int> startingCells) {
    for (int i = 0; i < cellList.length; i++) {
      if (cellList[i].state != 'inerte') {
        cellList[i].state = 'inflammable';
      }
    }
    if (startingCells.every((index) => index >= 0 && index < cellList.length)) {
      for (int index in startingCells) {
        cellList[index].state = 'enflammée';
        cellList[index].lastUpdatedRound = 0;
        cellList[index].fireDuration = 0;
      }
    } else {
      print('Les indices donnés ne sont pas valides.');
    }
    return cellList;
  }

  // Fonction pour initialiser la simulation avec les paramètres donnés
  InitialisationSimulation initialiserSimulation(
      Climat climat, Terrain terrain, Wind wind) {
    return InitialisationSimulation(climat, terrain, wind);
  }

  // Fonction pour simuler les rounds de la simulation
  void simulateRounds(List<Cell> cells, int rounds, Wind wind, Climat climat) {
    for (int round = 1; round <= rounds; round++) {
      List<int> newFires = [];
      for (int i = 0; i < cells.length; i++) {
        if ((round <= 2 && cells[i].state == 'enflammée') || (round > 2 && (cells[i].state == 'enflammée' || cells[i].state == 'brûlé et chaud'))) {
          if (round > 2 && cells[i].state == 'enflammée') {
            List<int> neighbors = getNeighbors(i, cells.length);
            for (int neighbor in neighbors) {
              if (cells[neighbor].state == 'inflammable') {
                double fireProbability = getFireProbability(climat);
                if (random.nextDouble() <= fireProbability) {
                  newFires.add(neighbor);
                }
              }
            }
          }
          updateCellState(cells[i], wind, climat, round);
        }
      }
      for (int index in newFires) {
        cells[index].state = 'enflammée';
        cells[index].lastUpdatedRound = round;
        cells[index].fireDuration = 0;
      }

      // Affichage de l'état des cellules à chaque round
      print("État des cellules au Round $round:");
      for (int i = 0; i < cells.length; i++) {
        print('Cellule $i : ${cells[i].state}');
        print('Cellule $i : Dernière mise à jour au round ${cells[i].lastUpdatedRound}');
      }
    }
  }

  // Fonction pour obtenir les voisins d'une cellule
  List<int> getNeighbors(int index, int length) {
    List<int> neighbors = [];
    if (index % 6 != 0) {
      neighbors.add(index - 1); // Voisin de gauche
    }
    if (index % 6 != 5) {
      neighbors.add(index + 1); // Voisin de droite
    }
    if (index >= 6) {
      neighbors.add(index - 6); // Voisin du haut
    }
    if (index < length - 6) {
      neighbors.add(index + 6); // Voisin du bas
    }

    return neighbors;
  }

  // Fonction pour mettre à jour l'état d'une cellule en fonction du vent et du climat
  void updateCellState(Cell cell, Wind wind, Climat climat, int round) {
    if (cell.state == 'enflammée') {
      if (cell.fireDuration < 2) {
        cell.fireDuration++;
        cell.lastUpdatedRound = round;
      } else {
        cell.state = 'brûlé et chaud';
        cell.fireDuration = 0;
        cell.lastUpdatedRound = round;
      }
    } else if (cell.state == 'brûlé et chaud') {
      double probability = random.nextDouble();
      if (probability <= 0.4) {
        cell.state = 'brûlé et froid';
        cell.lastUpdatedRound = round;
      } else {
        cell.lastUpdatedRound = round;
        // Envoyer des brandons avec une probabilité
        double fireBrandProbability = 0.005 * (1 + windForce(wind));
        if (random.nextDouble() <= fireBrandProbability) {
          igniteNeighbors(cell.index, climat, round);
        }
      }
    }
  }

  // Fonction pour obtenir la probabilité d'incendie en fonction du climat
  double getFireProbability(Climat climat) {
    switch (climat) {
      case Climat.humid:
        return 0.1;
      case Climat.normal:
        return 0.3;
      case Climat.dry:
        return 0.6;
      case Climat.veryDry:
        return 0.9;
      default:
        return 0.0;
    }
  }

  // Fonction pour obtenir la force du vent en fonction de son type
  int windForce(Wind wind) {
    switch (wind) {
      case Wind.none:
        return 0;
      case Wind.moderate:
        return 1;
      case Wind.strong:
        return 2;
      case Wind.violent:
        return 3;
      default:
        return 0;
    }
  }

  // Fonction pour enflammer les voisins d'une cellule
  void igniteNeighbors(int index, Climat climat, int round) {
    List<int> neighbors = getNeighbors(index, cells.length);
    for (int neighborIndex in neighbors) {
      if (cells[neighborIndex].state == 'inflammable') {
        double fireProbability = getFireProbability(climat);
        if (random.nextDouble() <= fireProbability) {
          cells[neighborIndex].state = 'enflammée';
          cells[neighborIndex].lastUpdatedRound = round;
          cells[neighborIndex].fireDuration = 0;
        }
      }
    }
  }

  // Fonction pour enregistrer l'état final de la grille dans un fichier
  Future<void> _saveGridToFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/grid_state.txt';
    final file = File(path);

    String content = cells.map((cell) => 'Cell ${cell.index}: ${cell.state}').join('\n');
    await file.writeAsString(content);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('État final de la grille enregistré dans $path')),
    );
  }

  // Fonction pour obtenir la couleur en fonction de l'état de la cellule
  Color getColorForState(String state) {
    switch (state) {
      case 'inflammable':
        return Colors.green;
      case 'enflammée':
        return Colors.red;
      case 'brûlé et chaud':
        return Colors.orange;
      case 'brûlé et froid':
        return Colors.black;
      case 'inerte':
        return Colors.grey;
      default:
        return Colors.white;
    }
  }

  // Fonction pour obtenir la couleur du texte en fonction de l'état de la cellule
  Color getTextColorForState(String state) {
    switch (state) {
      case 'inflammable':
      case 'brûlé et chaud':
        return Colors.black;
      case 'enflammée':
      case 'brûlé et froid':
      case 'inerte':
        return Colors.white;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        'Veuillez sélectionner les indices des cellules à enflammer (Attention à ne pas choisir une case inerte !) :',
                        style: TextStyle(fontSize: 14),
                      ),
                      Wrap(
                        spacing: 4.0,
                        runSpacing: 4.0,
                        children: List<Widget>.generate(24, (int index) {
                          return ChoiceChip(
                            label: Text('$index'),
                            selected: selectedIndices[index],
                            onSelected: (bool selected) {
                              setState(() {
                                selectedIndices[index] = selected;
                              });
                            },
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 6,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            childAspectRatio: 1.0,
                          ),
                          itemCount: cells.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: getColorForState(cells[index].state),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Center(
                                child: Text(
                                  '${cells[index].index}',
                                  style: TextStyle(
                                    color: getTextColorForState(cells[index].state),
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Choisissez le climat :', style: TextStyle(fontSize: 14)),
                      DropdownButton<Climat>(
                        value: selectedClimat,
                        onChanged: (Climat? newValue) {
                          setState(() {
                            selectedClimat = newValue!;
                            resetSimulation();
                          });
                        },
                        items: Climat.values.map<DropdownMenuItem<Climat>>((Climat value) {
                          return DropdownMenuItem<Climat>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      const Text('Choisissez le terrain :', style: TextStyle(fontSize: 14)),
                      DropdownButton<Terrain>(
                        value: selectedTerrain,
                        onChanged: (Terrain? newValue) {
                          setState(() {
                            selectedTerrain = newValue!;
                            resetSimulation();
                          });
                        },
                        items: Terrain.values.map<DropdownMenuItem<Terrain>>((Terrain value) {
                          return DropdownMenuItem<Terrain>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      const Text('Choisissez le vent :', style: TextStyle(fontSize: 14)),
                      DropdownButton<Wind>(
                        value: selectedWind,
                        onChanged: (Wind? newValue) {
                          setState(() {
                            selectedWind = newValue!;
                          });
                        },
                        items: Wind.values.map<DropdownMenuItem<Wind>>((Wind value) {
                          return DropdownMenuItem<Wind>(
                            value: value,
                            child: Text(value.toString().split('.').last),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _roundsController,
                        decoration: const InputDecoration(
                          hintText: 'Entrez le nombre de rounds',
                        ),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _handleConfirmation,
                        child: const Text('Confirmer'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: resetSimulation,
                        child: const Text('Réinitialiser'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: _saveGridToFile,
                        child: const Text('Sauvegarder'),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Légende des couleurs :',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          _buildColorLegend(Colors.green, 'Inflammable'),
                          _buildColorLegend(Colors.red, 'Enflammée'),
                          _buildColorLegend(Colors.orange, 'Brûlé et chaud'),
                          _buildColorLegend(Colors.black, 'Brûlé et froid'),
                          _buildColorLegend(Colors.grey, 'Inerte'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildColorLegend(Color color, String description) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 5),
        Text(description),
      ],
    );
  }
}

enum Climat { humid, normal, dry, veryDry }

enum Terrain { continu, close, spaced, sparse }

enum Wind { none, moderate, strong, violent }

class InitialisationSimulation {
  Climat climat;
  Terrain terrain;
  Wind wind;

  InitialisationSimulation(this.climat, this.terrain, this.wind);
}
